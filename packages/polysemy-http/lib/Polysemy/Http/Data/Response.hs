module Polysemy.Http.Data.Response (
  module Polysemy.Http.Data.Response,
  Status(Status),
) where

import Network.HTTP.Client (BodyReader)
import Network.HTTP.Types (
  Status(Status),
  statusIsClientError,
  statusIsInformational,
  statusIsRedirection,
  statusIsServerError,
  statusIsSuccessful,
  )
import qualified Text.Show as Text (Show(show))

import Polysemy.Http.Data.Header (Header)

-- |The response produced by 'Polysemy.Http.Data.Http'.
data Response b =
  Response {
    -- |Uses the type from 'Network.HTTP' for convenience
    status :: Status,
    -- |parameterized in the body to allow different interpreters to use other representations.
    body :: b,
    -- |Does not use the type from 'Network.HTTP' because it is an alias.
    headers :: [Header]
  }
  deriving (Eq, Show)

instance {-# overlapping #-} Show (Response BodyReader) where
  show (Response s _ hs) =
    [qt|StreamingResponse { status :: #{s}, headers :: #{hs} }|]

-- |Match on a response with a 1xx status.
pattern Info ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Info s b h <- Response s@(statusIsInformational -> True) b h

-- |Match on a response with a 2xx status.
pattern Success ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Success s b h <- Response s@(statusIsSuccessful -> True) b h

-- |Match on a response with a 3xx status.
pattern Redirect ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Redirect s b h <- Response s@(statusIsRedirection -> True) b h

-- |Match on a response with a 4xx status.
pattern Client ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Client s b h <- Response s@(statusIsClientError -> True) b h

-- |Match on a response with a 5xx status.
pattern Server ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Server s b h <- Response s@(statusIsServerError -> True) b h
