module Network.HTTP.Polysemy.Data.HttpError where

data HttpError =
  AuthFailed Text
  |
  ServerError Int Text
  |
  Parse LByteString Text
  |
  ChunkFailed Text
  |
  Unexpected Text
  |
  FileSystem Text
  deriving (Eq, Show)
