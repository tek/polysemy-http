module Polysemy.Http.Data.Header where

newtype HeaderName =
  HeaderName { unHeaderName :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

newtype HeaderValue =
  HeaderValue { unHeaderValue :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

data Header =
  Header {
    name :: HeaderName,
    value :: HeaderValue
  }
  deriving (Eq, Show)
