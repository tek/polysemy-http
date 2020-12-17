module Polysemy.Http (
  -- $intro
  module Polysemy.Http.Data.Http,
  -- * Interpreters
  module Polysemy.Http.Native,
  module Polysemy.Http.Strict,
  -- * Request and Response
  module Polysemy.Http.Data.Request,
  module Polysemy.Http.Data.Response,
  module Polysemy.Http.Data.Header,
  withPort,
  withTls,
  simple,
  get,
  post,
  put,
  delete,
  fromUrl,
  getUrl,
  postUrl,
  putUrl,
  deleteUrl,
  cookie,
  addCookies,
  addCookie,
  HttpError(..),
  -- * Streaming
  module Polysemy.Http.Http,
  module Polysemy.Http.Data.StreamEvent,
  -- * Entity
  EntityDecode,
  decode,
  decodeStrict,
  EntityEncode,
  encode,
  encodeStrict,
  Entities,
  Decode,
  Encode,
  Decoders,
  Encoders,
  EntityError(EntityError),
  module Polysemy.Http.AesonEntity,
  -- * Utilities
  -- ** Connection Pool
  module Polysemy.Http.Data.Manager,
  -- ** Logging
  module Polysemy.Http.Data.Log,
  module Polysemy.Http.Log,
) where

import Polysemy.Http.AesonEntity (interpretEntityDecodeAeson, interpretEntityEncodeAeson)
import Polysemy.Http.Data.Entity (
  Decode,
  Decoders,
  Encode,
  Encoders,
  Entities,
  EntityDecode,
  EntityEncode,
  EntityError(EntityError),
  decode,
  decodeStrict,
  encode,
  encodeStrict,
  )
import Polysemy.Http.Data.Header (Header(..), HeaderName(..), HeaderValue(..))
import Polysemy.Http.Data.Http (Http, request, response, stream)
import Polysemy.Http.Data.HttpError (HttpError(..))
import Polysemy.Http.Data.Log (Log)
import Polysemy.Http.Data.Manager (Manager)
import Polysemy.Http.Data.Request (
  Body(..),
  Host(..),
  Method(..),
  Path(..),
  Port(..),
  QueryKey(..),
  QueryValue(..),
  Request(..),
  Tls(..),
  )
import Polysemy.Http.Data.Response (
  Response(..),
  pattern Client,
  pattern Info,
  pattern Redirect,
  pattern Server,
  pattern Success,
  )
import Polysemy.Http.Data.StreamEvent (StreamEvent(..))
import Polysemy.Http.Http (streamResponse)
import Polysemy.Http.Log (interpretLogNull, interpretLogStdout)
import Polysemy.Http.Native (interpretHttpNative)
import Polysemy.Http.Request (
  addCookie,
  addCookies,
  cookie,
  delete,
  deleteUrl,
  fromUrl,
  get,
  getUrl,
  post,
  postUrl,
  put,
  putUrl,
  simple,
  withPort,
  withTls,
  )
import Polysemy.Http.Strict (interpretHttpStrict)
import Prelude hiding (get, put)

-- $intro
-- A basic 'Polysemy' effect abstracting HTTP requests:
--
-- @
-- import Polysemy (resourceToIO, runM)
-- import qualified Polysemy.Http as Http
-- import Polysemy.Http (interpretHttpNative, interpretLogStdout)
--
-- main :: IO ()
-- main = do
--   result <- runM $
--     resourceToIO $
--     interpretLogStdout $
--     interpretHttpNative $
--     Http.request (Http.get "hackage.haskell.org" "package\/polysemy-http")
--   print result
-- @
