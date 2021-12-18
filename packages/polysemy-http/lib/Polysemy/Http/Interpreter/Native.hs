{-# options_haddock prune #-}

-- |Description: Http Interpreters, Internal
module Polysemy.Http.Interpreter.Native where

import qualified Data.CaseInsensitive as CaseInsensitive
import Data.CaseInsensitive (foldedCase)
import qualified Network.HTTP.Client as HTTP
import Network.HTTP.Client (BodyReader, httpLbs, responseClose, responseOpen)
import Network.HTTP.Client.Internal (CookieJar (CJ))
import Polysemy (getInitialStateT, interpretH, runTSimple)
import qualified Polysemy.Log as Log
import Polysemy.Log (Log)
import Polysemy.Resource (Resource, bracket)

import Polysemy.Http.Data.Header (Header (Header), unHeaderName, unHeaderValue)
import qualified Polysemy.Http.Data.HttpError as HttpError
import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (
  Body (Body),
  Host (Host),
  Path (Path),
  Request (Request),
  Tls (Tls),
  methodUpper,
  unPort,
  unQueryKey,
  unQueryValue,
  )
import Polysemy.Http.Data.Response (Response (Response))
import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Effect.Http (Http)
import qualified Polysemy.Http.Effect.Manager as Manager
import Polysemy.Http.Effect.Manager (Manager)
import Polysemy.Http.Interpreter.Manager (interpretManager)

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
  Response (HTTP.responseStatus response) (HTTP.responseBody response) headers (HTTP.responseCookieJar response)
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

withResponse ::
  Members [Embed IO, Log, Resource, Manager] r =>
  Request ->
  (Response BodyReader -> Sem r a) ->
  Sem r (Either HttpError a)
withResponse request f =
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
      Right <$> f (convertResponse response)
    use (Left err) =
      pure (Left err)
    closeFailed err =
      Log.error [exon|closing response failed: #{err}|]
{-# inline withResponse #-}

distribEither ::
  Functor f =>
  Either err (f a) ->
  Sem (WithTactics e f m r) (f (Either err a))
distribEither = \case
  Right fa ->
    pure (Right <$> fa)
  Left err -> do
    s <- getInitialStateT
    pure (Left err <$ s)
{-# inline distribEither #-}

-- |Same as 'interpretHttpNative', but the interpretation of 'Manager' is left to the user.
interpretHttpNativeWith ::
  Members [Embed IO, Log, Resource, Manager] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNativeWith =
  interpretH \case
    Http.Response request f -> do
      distribEither =<< withResponse request ((\x -> runTSimple x) . f)
    Http.Request request -> do
      Log.debug [exon|http request: #{show request}|]
      manager <- Manager.get
      liftT do
        response <- executeRequest manager request
        response <$ Log.debug [exon|http response: #{show response}|]
    Http.Stream request handler -> do
      Log.debug [exon|http stream request: #{show request}|]
      distribEither =<< withResponse request ((\x -> runTSimple x). handler)
    Http.ConsumeChunk body ->
      pureT . first HttpError.ChunkFailed =<< tryAny body
{-# inline interpretHttpNativeWith #-}

-- |Interpret @'Http' 'BodyReader'@ using the native 'Network.HTTP.Client' implementation.
-- 'BodyReader' is an alias for @'IO' 'ByteString'@, it is how http-client represents chunks.
-- This uses the default interpreter for 'Manager'.
interpretHttpNative ::
  Members [Embed IO, Log, Resource] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNative =
  interpretManager . interpretHttpNativeWith . raiseUnder
{-# inline interpretHttpNative #-}
