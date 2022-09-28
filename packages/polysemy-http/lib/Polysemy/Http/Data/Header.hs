{-# options_haddock prune #-}

-- |Description: Header Data Types, Internal
module Polysemy.Http.Data.Header where

-- |The name of a header.
newtype HeaderName =
  HeaderName { unHeaderName :: Text }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

json ''HeaderName

-- |The value of a header.
newtype HeaderValue =
  HeaderValue { unHeaderValue :: Text }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

json ''HeaderValue

-- |An HTTP header.
data Header =
  Header {
    name :: HeaderName,
    value :: HeaderValue
  }
  deriving stock (Eq, Show, Generic)

json ''Header
