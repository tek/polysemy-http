{-# options_haddock prune #-}

-- |Description: Entity Effects, Internal
module Polysemy.Http.Effect.Entity where

-- |Generic error type for decoders.
data EntityError =
  EntityError {
    body :: Text,
    message :: Text
  }
  deriving stock (Eq, Show)

-- |Abstraction of json encoding, potentially usable for other content types like xml.
data EntityEncode d :: Effect where
  EncodeLazy :: d -> EntityEncode d m LByteString
  EncodeStrict :: d -> EntityEncode d m ByteString

makeSem_ ''EntityEncode

-- |Lazily encode a value of type @d@ to a 'LByteString'
encodeLazy ::
  ∀ d r .
  Member (EntityEncode d) r =>
  d ->
  Sem r LByteString

-- |Strictly encode a value of type @d@ to a 'ByteString'
encodeStrict ::
  ∀ d r .
  Member (EntityEncode d) r =>
  d ->
  Sem r ByteString

-- |Strictly encode a value of type @d@ to a 'ByteString'
encode ::
  ∀ d r .
  Member (EntityEncode d) r =>
  d ->
  Sem r ByteString
encode =
  encodeStrict

-- |Abstraction of json decoding, potentially usable for other content types like xml.
data EntityDecode d :: Effect where
  DecodeLazy :: LByteString -> EntityDecode d m (Either EntityError d)
  DecodeStrict :: ByteString -> EntityDecode d m (Either EntityError d)

makeSem_ ''EntityDecode

-- |Lazily decode a 'LByteString' to a value of type @d@
decodeLazy ::
  ∀ d r .
  Member (EntityDecode d) r =>
  LByteString ->
  Sem r (Either EntityError d)

-- |Strictly decode a 'ByteString' to a value of type @d@
decodeStrict ::
  ∀ d r .
  Member (EntityDecode d) r =>
  ByteString ->
  Sem r (Either EntityError d)

-- |Strictly decode a 'ByteString' to a value of type @d@
decode ::
  ∀ d r .
  Member (EntityDecode d) r =>
  ByteString ->
  Sem r (Either EntityError d)
decode =
  decodeStrict

-- |Marker type to be used with 'Entities'
data Encode a

-- |Marker type to be used with 'Entities'
data Decode a

-- |Convenience constraint for requiring multiple entity effects, to be used like 'Polysemy.Members'.
--
-- @
-- foo :: Entities [Encode Int, Decode Double] r => Sem r ()
-- @
type family Entities es r :: Constraint where
  Entities '[] r = ()
  Entities (Encode d ': ds) r = (Member (EntityEncode d) r, Entities ds r)
  Entities (Decode d ': ds) r = (Member (EntityDecode d) r, Entities ds r)

-- |Convenience constraint for requiring multiple encoders.
--
-- @
-- foo :: Encoders [Int, Double] r => Sem r ()
-- @
type family Encoders es r :: Constraint where
  Encoders '[] r = ()
  Encoders (d ': ds) r = (Member (EntityEncode d) r, Encoders ds r)

-- |Convenience constraint for requiring multiple decoders.
--
-- @
-- foo :: Decoders [Int, Double] r => Sem r ()
-- @
type family Decoders ds r :: Constraint where
  Decoders '[] r = ()
  Decoders (d ': ds) r = (Member (EntityDecode d) r, Decoders ds r)
