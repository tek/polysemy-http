{-# options_haddock prune #-}
-- |Description: Response Data Types, Internal
module Polysemy.Http.Data.Response (
  module Polysemy.Http.Data.Response,
  Status(Status),
) where

import Network.HTTP.Client (BodyReader, CookieJar)
import Network.HTTP.Types (
  Status (Status),
  statusIsClientError,
  statusIsInformational,
  statusIsRedirection,
  statusIsServerError,
  statusIsSuccessful,
  )
import qualified Text.Show as Text (Show (show))

import Polysemy.Http.Data.Header (Header)

-- |The response produced by 'Polysemy.Http.Effect.Http'.
data Response b =
  Response {
    -- |Uses the type from 'Network.HTTP' for convenience.
    _status :: Status,
    -- |The body might be evaluated or an 'IO' action.
    _body :: b,
    -- |Does not use the type from 'Network.HTTP' because it is an alias.
    _headers :: [Header],
    -- |The native cookie jar.
    _cookies :: CookieJar
  }
  deriving (Show)

instance {-# overlapping #-} Show (Response BodyReader) where
  show (Response s _ hs _) =
    [qt|StreamingResponse { status :: #{s}, headers :: #{hs} }|]

instance Eq b => Eq (Response b) where
  Response ls lb lh _ == Response rs rb rh _ =
    ls == rs && lb == rb && lh == rh

-- |Match on a response with a 1xx status.
pattern Info ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Info s b h <- Response s@(statusIsInformational -> True) b h _

-- |Match on a response with a 2xx status.
pattern Success ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Success s b h <- Response s@(statusIsSuccessful -> True) b h _

-- |Match on a response with a 3xx status.
pattern Redirect ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Redirect s b h <- Response s@(statusIsRedirection -> True) b h _

-- |Match on a response with a 4xx status.
pattern Client ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Client s b h <- Response s@(statusIsClientError -> True) b h _

-- |Match on a response with a 5xx status.
pattern Server ::
  Status ->
  b ->
  [Header] ->
  Response b
pattern Server s b h <- Response s@(statusIsServerError -> True) b h _
