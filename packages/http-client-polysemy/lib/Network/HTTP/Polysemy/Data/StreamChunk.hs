module Network.HTTP.Polysemy.Data.StreamChunk where

newtype StreamChunk =
  StreamChunk ByteString
  deriving (Eq, Show)
