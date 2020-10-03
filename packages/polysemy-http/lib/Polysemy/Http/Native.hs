module Polysemy.Http.Native where

import qualified Data.CaseInsensitive as CaseInsensitive
import Data.CaseInsensitive (foldedCase)
import qualified Network.HTTP.Client as HTTP
import Network.HTTP.Client (BodyReader, httpLbs, responseClose, responseOpen)
import Network.HTTP.Client.Internal (CookieJar(CJ))
import Polysemy (Tactical, interpretH, runT)
import qualified Polysemy.Http.Data.Log as Log
import Polysemy.Http.Data.Log (Log)
import Polysemy.Resource (Resource, bracket)

import Polysemy.Http.Data.Header (Header(Header), unHeaderName, unHeaderValue)
import qualified Polysemy.Http.Data.Http as Http
import Polysemy.Http.Data.Http (Http)
import qualified Polysemy.Http.Data.HttpError as HttpError
import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Manager as Manager
import Polysemy.Http.Data.Manager (Manager)
import Polysemy.Http.Data.Request (
  Body(Body),
  Host(Host),
  Path(Path),
  Request(Request),
  Tls(Tls),
  methodUpper,
  unPort,
  unQueryKey,
  unQueryValue,
  )
import Polysemy.Http.Data.Response (Response(Response))
import Polysemy.Http.Manager (interpretManager)

-- |Converts a 'Request' to a native 'N.Request'.
nativeRequest :: Request -> HTTP.Request
nativeRequest (Request method (Host host) portOverride (Tls tls) (Path path) headers (CJ cookies) query (Body body)) =
  HTTP.setQueryString queryParams HTTP.defaultRequest {
    HTTP.host = encodeUtf8 host,
    HTTP.port = port,
    HTTP.secure = tls,
    HTTP.method = encodeUtf8 (methodUpper method),
    HTTP.requestHeaders = encodedHeaders,
    HTTP.path = encodeUtf8 path,
    HTTP.requestBody = HTTP.RequestBodyLBS body,
    HTTP.cookieJar = CJ . toList <$> nonEmpty cookies
  }
  where
    queryParams =
      bimap (encodeUtf8 . unQueryKey) (fmap (encodeUtf8 . unQueryValue)) <$> query
    port =
      maybe (if tls then 443 else 80) unPort portOverride
    encodedHeaders =
      bimap (CaseInsensitive.mk . encodeUtf8 . unHeaderName) (encodeUtf8 . unHeaderValue) <$> headers

convertResponse :: HTTP.Response b -> Response b
convertResponse response =
  Response (HTTP.responseStatus response) (HTTP.responseBody response) headers
  where
    headers =
      header <$> HTTP.responseHeaders response
    header (foldedCase -> decodeUtf8 -> name, decodeUtf8 -> value) =
      Header (fromString name) (fromString value)

internalError ::
  Member (Embed IO) r =>
  IO a ->
  Sem r (Either HttpError a)
internalError =
  tryHoist HttpError.Internal

executeRequest ::
  Member (Embed IO) r =>
  HTTP.Manager ->
  Request ->
  Sem r (Either HttpError (Response LByteString))
executeRequest manager request =
  fmap convertResponse <$> internalError (httpLbs (nativeRequest request) manager)

-- |Default handler for 'Http.Stream'.
-- Uses 'bracket' to acquire and close the connection, calling 'StreamEvent.Acquire' and 'StreamEvent.Release' in the
-- corresponding phases.
httpStream ::
  Members [Embed IO, Log, Resource, Manager] r =>
  Request ->
  (Response BodyReader -> m (Either HttpError a)) ->
  Tactical (Http BodyReader) m r (Either HttpError a)
httpStream request handler =
  bracket acquire release use
  where
    acquire = do
      manager <- Manager.get
      internalError (responseOpen (nativeRequest request) manager)
    release (Right response) =
      tryAny (responseClose response) >>= traverseLeft closeFailed
    release (Left _) =
      unit
    use (Right response) = do
      raise . interpretHttpNativeWith =<< runT (handler (convertResponse response))
    use (Left err) =
      pureT (Left err)
    closeFailed err =
      Log.error [qt|closing response failed: #{err}|]
{-# INLINE httpStream #-}

-- |Same as 'interpretHttpNative', but the interpretation of 'Manager' is left to the user.
interpretHttpNativeWith ::
  Members [Embed IO, Log, Resource, Manager] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNativeWith =
  interpretH \case
    Http.Request request -> do
      Log.debug $ [qt|http request: #{request}|]
      manager <- Manager.get
      liftT do
        response <- executeRequest manager request
        response <$ Log.debug [qt|http response: #{response}|]
    Http.Stream request handler ->
      httpStream request handler
    Http.ConsumeChunk body ->
      pureT =<< mapLeft HttpError.ChunkFailed <$> tryAny body
{-# INLINE interpretHttpNativeWith #-}

-- |Interpret @'Http' 'BodyReader'@ using the native 'Network.HTTP.Client' implementation.
-- 'BodyReader' is an alias for @'IO' 'ByteString'@, it is how http-client represents chunks.
-- This uses the default interpreter for 'Manager'.
interpretHttpNative ::
  Members [Embed IO, Log, Resource] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNative =
  interpretManager . interpretHttpNativeWith . raiseUnder
{-# INLINE interpretHttpNative #-}
