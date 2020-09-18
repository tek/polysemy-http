module Polysemy.Http.AesonEntity where

import Data.Aeson (eitherDecode', eitherDecodeStrict', encode)

import Polysemy.Http.Data.Entity (EntityDecode, EntityEncode, EntityError(EntityError))
import qualified Polysemy.Http.Data.Entity as Entity (EntityDecode(..), EntityEncode(..))

-- |Interpreter for 'EntityEncode' that uses Aeson.
interpretEntityEncodeAeson ::
  ToJSON d =>
  Sem (EntityEncode d : r) a ->
  Sem r a
interpretEntityEncodeAeson =
  interpret \case
    Entity.Encode a ->
      pure (encode a)
    Entity.EncodeStrict a ->
      pure (toStrict (encode a))
{-# INLINE interpretEntityEncodeAeson #-}

decodeWith ::
  ConvertUtf8 Text s =>
  (s -> Either String a) ->
  s ->
  Sem r (Either EntityError a)
decodeWith dec body =
  pure . mapLeft (EntityError (decodeUtf8 body) . toText) $ dec body
{-# INLINE decodeWith #-}

-- |Interpreter for 'EntityDecode' that uses Aeson.
interpretEntityDecodeAeson ::
  FromJSON d =>
  Sem (EntityDecode d : r) a ->
  Sem r a
interpretEntityDecodeAeson =
  interpret \case
    Entity.Decode body ->
      decodeWith eitherDecode' body
    Entity.DecodeStrict body ->
      decodeWith eitherDecodeStrict' body
{-# INLINE interpretEntityDecodeAeson #-}
