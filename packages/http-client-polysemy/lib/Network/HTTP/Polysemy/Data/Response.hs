module Network.HTTP.Polysemy.Data.Response where

import Network.HTTP.Client (BodyReader)
import qualified Text.Show as Text (Show(show))

import Network.HTTP.Polysemy.Data.Header (Header)

data Response b =
  Response {
    status :: Int,
    body :: b,
    headers :: [Header]
  }
  deriving (Eq, Show)

instance {-# OVERLAPPING #-} Show (Response BodyReader) where
  show (Response s _ hs) =
    [qt|StreamingResponse { status :: #{s}, headers :: #{hs} }|]
