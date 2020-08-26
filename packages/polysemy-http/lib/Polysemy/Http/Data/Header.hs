module Polysemy.Http.Data.Header where

-- |The name of a header.
newtype HeaderName =
  HeaderName { unHeaderName :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |The value of a header.
newtype HeaderValue =
  HeaderValue { unHeaderValue :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |An HTTP header.
data Header =
  Header {
    name :: HeaderName,
    value :: HeaderValue
  }
  deriving (Eq, Show)
