module Polysemy.Http.Data.Entity where

-- |Generic error type for decoders.
data EntityError =
  EntityError {
    body :: Text,
    message :: Text
  }
  deriving (Eq, Show)

-- |Abstraction of json encoding, potentially usable for other content types like xml.
data EntityEncode d :: Effect where
  Encode :: d -> EntityEncode d m LByteString
  EncodeStrict :: d -> EntityEncode d m ByteString

makeSem ''EntityEncode

-- |Abstraction of json decoding, potentially usable for other content types like xml.
data EntityDecode d :: Effect where
  Decode :: LByteString -> EntityDecode d m (Either EntityError d)
  DecodeStrict :: ByteString -> EntityDecode d m (Either EntityError d)

makeSem ''EntityDecode

-- |Marker type to be used with 'Entities'
data Encode a
data Decode a

-- |Convenience constraint for requiring multiple entity effects, to be used like 'Polysemy.Members'.
-- @
-- foo :: Entities [Encode Int, Decode Double] r => Sem r ()
-- @
type family Entities es r :: Constraint where
  Entities '[] r = ()
  Entities (Encode d ': ds) r = (Member (EntityEncode d) r, Entities ds r)
  Entities (Decode d ': ds) r = (Member (EntityDecode d) r, Entities ds r)

-- |Convenience constraint for requiring multiple encoders.
-- @
-- foo :: Encoders [Int, Double] r => Sem r ()
-- @
type family Encoders es r :: Constraint where
  Encoders '[] r = ()
  Encoders (d ': ds) r = (Member (EntityEncode d) r, Encoders ds r)

-- |Convenience constraint for requiring multiple decoders.
-- @
-- foo :: Decoders [Int, Double] r => Sem r ()
-- @
type family Decoders ds r :: Constraint where
  Decoders '[] r = ()
  Decoders (d ': ds) r = (Member (EntityDecode d) r, Decoders ds r)
