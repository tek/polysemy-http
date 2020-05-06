module Polysemy.Http.Data.Header where

data Header =
  Header {
     name :: Text,
     value :: Text
  }
  deriving (Eq, Show)
