module Polysemy.Http.Data.StreamChunk where

-- |A single chunk produced by 'Network.HTTP.Client.BodyReader'.
newtype StreamChunk =
  StreamChunk ByteString
  deriving (Eq, Show)
