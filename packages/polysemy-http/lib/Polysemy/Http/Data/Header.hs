{-# OPTIONS_GHC -fclear-plugins #-}

module Polysemy.Http.Data.Header where

-- |The name of a header.
newtype HeaderName =
  HeaderName { unHeaderName :: Text }
  deriving (Eq, Show, Generic)
  deriving newtype (IsString)

defaultJson ''HeaderName

-- |The value of a header.
newtype HeaderValue =
  HeaderValue { unHeaderValue :: Text }
  deriving (Eq, Show, Generic)
  deriving newtype (IsString)

defaultJson ''HeaderValue

-- |An HTTP header.
data Header =
  Header {
    name :: HeaderName,
    value :: HeaderValue
  }
  deriving (Eq, Show, Generic)

defaultJson ''Header
