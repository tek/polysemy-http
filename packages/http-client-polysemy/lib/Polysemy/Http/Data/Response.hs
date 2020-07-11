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

pattern Info ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Info s b h <- Response s b h where
  Info s b h | s >= 100 && s < 200 =
    Response s b h

pattern Success ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Success s b h <- Response s b h where
  Success s b h | s >= 200 && s < 300 =
    Response s b h

pattern Redirect ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Redirect s b h <- Response s b h where
  Redirect s b h | s >= 300 && s < 400 =
    Response s b h

pattern Client ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Client s b h <- Response s b h where
  Client s b h | s >= 400 && s < 500 =
    Response s b h

pattern Server ::
  Int ->
  b ->
  [Header] ->
  Response b
pattern Server s b h <- Response s b h where
  Server s b h | s >= 500 && s < 600 =
    Response s b h
