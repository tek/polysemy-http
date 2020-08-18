module Polysemy.Http.Data.StreamChunk where

newtype StreamChunk =
  StreamChunk ByteString
  deriving (Eq, Show)
