-- |Description: Polysemy Effects for HTTP clients
module Polysemy.Http (
  -- $intro
  module Polysemy.Http.Effect.Http,

  -- * Interpreters
  module Polysemy.Http.Interpreter.Native,
  module Polysemy.Http.Interpreter.Pure,

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
  decodeLazy,
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
  module Polysemy.Http.Interpreter.AesonEntity,

  -- * Utilities
  -- ** Connection Pool
  module Polysemy.Http.Effect.Manager,
  interpretManager,
  jsonRequest,
) where

import Prelude hiding (get, put)

import Polysemy.Http.Data.Header (Header (..), HeaderName (..), HeaderValue (..))
import Polysemy.Http.Data.HttpError (HttpError (..))
import Polysemy.Http.Data.Request (
  Body (..),
  Host (..),
  Method (..),
  Path (..),
  Port (..),
  QueryKey (..),
  QueryValue (..),
  Request (Request),
  Tls (..),
  )
import Polysemy.Http.Data.Response (
  pattern Client,
  pattern Info,
  pattern Redirect,
  Response (Response),
  pattern Server,
  pattern Success,
  )
import Polysemy.Http.Data.StreamEvent (StreamEvent (..))
import Polysemy.Http.Effect.Entity (
  Decode,
  Decoders,
  Encode,
  Encoders,
  Entities,
  EntityDecode,
  EntityEncode,
  EntityError (EntityError),
  decode,
  decodeLazy,
  decodeStrict,
  encode,
  encodeStrict,
  )
import Polysemy.Http.Effect.Http (Http, request, response)
import Polysemy.Http.Effect.Manager (Manager)
import Polysemy.Http.Http (streamResponse)
import Polysemy.Http.Interpreter.AesonEntity (
  interpretEntityDecodeAeson,
  interpretEntityDecodeAesonAs,
  interpretEntityDecodeAesonWith,
  interpretEntityEncodeAeson,
  interpretEntityEncodeAesonAs,
  )
import Polysemy.Http.Interpreter.Manager (interpretManager)
import Polysemy.Http.Interpreter.Native (interpretHttpNative)
import Polysemy.Http.Interpreter.Pure (interpretHttpPure)
import Polysemy.Http.Json (jsonRequest)
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

-- $intro
-- A basic Polysemy effect abstracting HTTP requests:
--
-- @
-- import Polysemy (resourceToIO, runM)
-- import Log (interpretLogStdout)
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
