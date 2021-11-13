{-# options_haddock prune #-}
-- |Description: Entity Aeson Interpreters, Internal
module Polysemy.Http.Interpreter.AesonEntity where

import Data.Aeson (eitherDecode', eitherDecodeStrict', encode)

import Polysemy.Http.Effect.Entity (EntityDecode, EntityEncode, EntityError (EntityError))
import qualified Polysemy.Http.Effect.Entity as Entity (EntityDecode (..), EntityEncode (..))

-- |Interpreter for 'EntityEncode' that uses Aeson and a different codec type.
-- The first parameter is the conversion function.
interpretEntityEncodeAesonAs ::
  ToJSON j =>
  (d -> j) ->
  Sem (EntityEncode d : r) a ->
  Sem r a
interpretEntityEncodeAesonAs convert =
  interpret \case
    Entity.Encode a ->
      pure (encode (convert a))
    Entity.EncodeStrict a ->
      pure (toStrict (encode (convert a)))
{-# inline interpretEntityEncodeAesonAs #-}

-- |Interpreter for 'EntityEncode' that uses Aeson.
interpretEntityEncodeAeson ::
  ToJSON d =>
  Sem (EntityEncode d : r) a ->
  Sem r a
interpretEntityEncodeAeson =
  interpretEntityEncodeAesonAs id
{-# inline interpretEntityEncodeAeson #-}

decodeWith ::
  ConvertUtf8 Text s =>
  (s -> Either String a) ->
  s ->
  Sem r (Either EntityError a)
decodeWith dec body =
  pure . mapLeft (EntityError (decodeUtf8 body) . toText) $ dec body
{-# inline decodeWith #-}

-- |Interpreter for 'EntityDecode' that uses Aeson and a different codec type.
-- The first parameter is the conversion function.
interpretEntityDecodeAesonAs ::
  FromJSON j =>
  (j -> d) ->
  Sem (EntityDecode d : r) a ->
  Sem r a
interpretEntityDecodeAesonAs convert =
  interpret \case
    Entity.Decode body ->
      fmap convert <$> decodeWith eitherDecode' body
    Entity.DecodeStrict body ->
      fmap convert <$> decodeWith eitherDecodeStrict' body
{-# inline interpretEntityDecodeAesonAs #-}

-- |Interpreter for 'EntityDecode' that uses Aeson.
interpretEntityDecodeAeson ::
  FromJSON d =>
  Sem (EntityDecode d : r) a ->
  Sem r a
interpretEntityDecodeAeson =
  interpretEntityDecodeAesonAs id
{-# inline interpretEntityDecodeAeson #-}
