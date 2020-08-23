module Polysemy.Http.Data.HttpError where

data HttpError =
  ChunkFailed Text
  |
  Internal Text
  deriving (Eq, Show)
