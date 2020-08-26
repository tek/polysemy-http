module Polysemy.Http.Data.Response where

import Network.HTTP.Client (BodyReader)
import Network.HTTP.Types (
  Status,
  statusIsClientError,
  statusIsInformational,
  statusIsRedirection,
  statusIsServerError,
  statusIsSuccessful,
  )
import qualified Text.Show as Text (Show(show))

import Polysemy.Http.Data.Header (Header)

data Response b =
  Response {
    status :: Status,
    body :: b,
    headers :: [Header]
  }
  deriving (Eq, Show)

instance {-# OVERLAPPING #-} Show (Response BodyReader) where
  show (Response s _ hs) =
    [qt|StreamingResponse { status :: #{s}, headers :: #{hs} }|]

pattern Info ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Info s b h <- Response s@(statusIsInformational -> True) b h

pattern Success ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Success s b h <- Response s@(statusIsSuccessful -> True) b h

pattern Redirect ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Redirect s b h <- Response s@(statusIsRedirection -> True) b h

pattern Client ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Client s b h <- Response s@(statusIsClientError -> True) b h

pattern Server ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Server s b h <- Response s@(statusIsServerError -> True) b h
