module Polysemy.Http.Data.Entity where

import Data.Aeson (FromJSON(parseJSON), withObject, (.:))
import Prelude hiding ((.:))

data EntityError =
  EntityError {
    body :: Text,
    message :: Text
  }
  deriving (Eq, Show)

data EntityEncode d m a where
  Encode :: d -> EntityEncode d m LByteString

makeSem ''EntityEncode

data EntityDecode d m a where
  Decode :: LByteString -> EntityDecode d m (Either EntityError d)

makeSem ''EntityDecode

data Encode a
data Decode a

type family Entities es r :: Constraint where
  Entities '[] r = ()
  Entities (Encode d ': ds) r = (Member (EntityEncode d) r, Entities ds r)
  Entities (Decode d ': ds) r = (Member (EntityDecode d) r, Entities ds r)

type family Encoders es r :: Constraint where
  Encoders '[] r = ()
  Encoders (d ': ds) r = (Member (EntityEncode d) r, Encoders ds r)

type family Decoders ds r :: Constraint where
  Decoders '[] r = ()
  Decoders (d ': ds) r = (Member (EntityDecode d) r, Decoders ds r)
