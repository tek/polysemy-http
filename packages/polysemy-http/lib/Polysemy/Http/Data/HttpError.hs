module Polysemy.Http.Data.HttpError where

-- |Indicates a critical error caused by an exception in the http-client backend.
data HttpError =
  ChunkFailed Text
  |
  Internal Text
  deriving (Eq, Show)
