module Polysemy.Http.Native where

import qualified Data.CaseInsensitive as CaseInsensitive
import Data.CaseInsensitive (foldedCase)
import Network.HTTP.Client (BodyReader, httpLbs, responseClose, responseOpen)
import qualified Network.HTTP.Client as HTTP (Manager)
import Network.HTTP.Simple (
  defaultRequest,
  getResponseBody,
  getResponseHeaders,
  getResponseStatus,
  setRequestBodyLBS,
  setRequestHeaders,
  setRequestHost,
  setRequestMethod,
  setRequestPath,
  setRequestPort,
  setRequestQueryString,
  setRequestSecure,
  )
import qualified Network.HTTP.Simple as N (Request, Response)
import qualified Network.HTTP.Types as N (statusCode)
import Polysemy (Tactical, interpretH, runT)
import qualified Polysemy.Http.Data.Log as Log
import Polysemy.Http.Data.Log (Log)
import Polysemy.Resource (Resource, bracket)

import Polysemy.Http.Data.Header (Header(Header))
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
  unHeaderName,
  unHeaderValue,
  unPort,
  unQueryKey,
  unQueryValue,
  )
import Polysemy.Http.Data.Response (Response(Response))
import Polysemy.Http.Manager (interpretManager)

nativeRequest :: Request -> N.Request
nativeRequest (Request method (Host host) portOverride (Tls tls) (Path path) headers query (Body body)) =
  cons defaultRequest
  where
    cons =
      scheme .
      setRequestMethod (encodeUtf8 $ methodUpper method) .
      setRequestHeaders encodedHeaders .
      setRequestHost (encodeUtf8 host) .
      setRequestPort port .
      setRequestPath (encodeUtf8 path) .
      setRequestQueryString queryParam .
      setRequestBodyLBS body
    queryParam =
      bimap (encodeUtf8 . unQueryKey) (fmap (encodeUtf8 . unQueryValue)) <$> query
    scheme =
      if tls then setRequestSecure True else id
    port =
      maybe (if tls then 443 else 80) unPort portOverride
    encodedHeaders =
      bimap (CaseInsensitive.mk . encodeUtf8 . unHeaderName) (encodeUtf8 . unHeaderValue) <$> headers

convertResponse :: N.Response b -> Response b
convertResponse response =
  Response (N.statusCode (getResponseStatus response)) (getResponseBody response) headers
  where
    headers =
      header <$> getResponseHeaders response
    header (foldedCase -> decodeUtf8 -> name, decodeUtf8 -> value) =
      Header name value

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

interpretHttpNativeWith ::
  Members [Embed IO, Log, Resource, Manager] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNativeWith =
  interpretH $ \case
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

interpretHttpNative ::
  Members [Embed IO, Log, Resource] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNative =
  interpretManager . interpretHttpNativeWith . raiseUnder
{-# INLINE interpretHttpNative #-}
