module Polysemy.Http.Data.Response where

import Network.HTTP.Client (BodyReader)
import qualified Text.Show as Text (Show(show))

import Polysemy.Http.Data.Header (Header)

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

statusInterval ::
  Int ->
  Int ->
  Int ->
  Maybe Int
statusInterval low high s | low <= s && s < high =
  Just s
statusInterval _ _ _ =
  Nothing

pattern Info ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Info s b h <- Response (statusInterval 100 200 -> Just s) b h

pattern Success ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Success s b h <- Response (statusInterval 200 300 -> Just s) b h

pattern Redirect ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Redirect s b h <- Response (statusInterval 300 400 -> Just s) b h

pattern Client ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Client s b h <- Response (statusInterval 400 500 -> Just s) b h

pattern Server ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Server s b h <- Response (statusInterval 400 500 -> Just s) b h
