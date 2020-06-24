module Polysemy.Http.AesonEntity where

import Data.Aeson (FromJSON, ToJSON, eitherDecode', encode)
import Polysemy (Sem, interpret)

import Polysemy.Http.Data.Entity (EntityDecode, EntityEncode, EntityError(EntityError))
import qualified Polysemy.Http.Data.Entity as Entity (EntityDecode(Decode), EntityEncode(Encode))

interpretEntityEncodeAeson ::
  ToJSON d =>
  Sem (EntityEncode d : r) a ->
  Sem r a
interpretEntityEncodeAeson =
  interpret $ \case
    Entity.Encode a ->
      pure (encode a)
{-# INLINE interpretEntityEncodeAeson #-}

interpretEntityDecodeAeson ::
  FromJSON d =>
  Sem (EntityDecode d : r) a ->
  Sem r a
interpretEntityDecodeAeson =
  interpret $ \case
    Entity.Decode body ->
      pure . mapLeft (EntityError (decodeUtf8 body) . toText) $ eitherDecode' body
{-# INLINE interpretEntityDecodeAeson #-}
