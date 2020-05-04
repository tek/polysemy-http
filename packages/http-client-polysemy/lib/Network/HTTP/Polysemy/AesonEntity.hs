module Network.HTTP.Polysemy.AesonEntity where

import Data.Aeson (FromJSON, ToJSON, eitherDecode', encode)
import Polysemy (Sem, interpret)

import Network.HTTP.Polysemy.Data.Entity (EntityDecode, EntityEncode, EntityError(EntityError))
import qualified Network.HTTP.Polysemy.Data.Entity as Entity (EntityDecode(Decode), EntityEncode(Encode))

interpretEntityEncodeAeson ::
  ToJSON d =>
  Sem (EntityEncode d : r) a ->
  Sem r a
interpretEntityEncodeAeson =
  interpret $ \case
    Entity.Encode a ->
      pure (encode a)

interpretEntityDecodeAeson ::
  FromJSON d =>
  Sem (EntityDecode d : r) a ->
  Sem r a
interpretEntityDecodeAeson =
  interpret $ \case
    Entity.Decode body ->
      pure . mapLeft (EntityError (decodeUtf8 body) . toText) $ eitherDecode' body
