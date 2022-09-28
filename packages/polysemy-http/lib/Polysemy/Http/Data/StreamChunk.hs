{-# options_haddock prune #-}
-- |Description: StreamChunk Data Type, Internal
module Polysemy.Http.Data.StreamChunk where

-- |A single chunk produced by 'Network.HTTP.Client.BodyReader'.
newtype StreamChunk =
  StreamChunk ByteString
  deriving stock (Eq, Show)
