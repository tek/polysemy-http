module Polysemy.Http.Native where

import Control.Exception.Lifted (try)
import qualified Data.CaseInsensitive as CaseInsensitive
import Data.CaseInsensitive (foldedCase)
import Network.Connection (settingDisableCertificateValidation)
import Network.HTTP.Client (BodyReader, httpLbs, newManager, responseClose, responseOpen)
import qualified Network.HTTP.Client as HTTP (Manager)
import Network.HTTP.Client.TLS (mkManagerSettings)
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
import Polysemy (interpretH, pureT, runT)
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
import Polysemy.Http.Data.Request (Request(Request), methodUpper)
import Polysemy.Http.Data.Response (Response(Response))
import Polysemy.Http.Manager (interpretManager)

nativeRequest :: Request -> N.Request
nativeRequest (Request method host tls path headers query body) =
  cons defaultRequest
  where
    cons =
      scheme .
      setRequestMethod (encodeUtf8 $ methodUpper method) .
      setRequestHeaders encodedHeaders .
      setRequestHost (encodeUtf8 host) .
      setRequestPath (encodeUtf8 path) .
      setRequestQueryString queryParam .
      setRequestBodyLBS body
    queryParam =
      second Just . bimap encodeUtf8 encodeUtf8 <$> query
    scheme =
      if tls then setRequestSecure True . setRequestPort 443 else id
    encodedHeaders =
      bimap (CaseInsensitive.mk . encodeUtf8) encodeUtf8 <$> headers

convertResponse :: N.Response b -> Response b
convertResponse response =
  Response (N.statusCode (getResponseStatus response)) (getResponseBody response) headers
  where
    headers =
      header <$> getResponseHeaders response
    header (foldedCase -> decodeUtf8 -> name, decodeUtf8 -> value) =
      Header name value

executeRequest ::
  Member (Embed IO) r =>
  HTTP.Manager ->
  Request ->
  Sem r (Either HttpError (Response LByteString))
executeRequest manager request =
  bimap err convertResponse <$> embed (try (httpLbs (nativeRequest request) manager))
  where
    err :: SomeException -> HttpError
    err =
      HttpError.Unexpected . show

interpretHttpNativeWith ::
  Members [Embed IO, Log, Resource, Manager] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNativeWith =
  interpretH $ \case
    Http.Request request -> do
      Log.debug $ "http request: " <> show request
      manager <- Manager.get
      liftT $ executeRequest manager request
    Http.Stream request handler ->
      bracket acquire release use
      where
        acquire = do
          manager <- Manager.get
          embed $ responseOpen (nativeRequest request) manager
        release response =
          embed $ responseClose response
        use response = do
          raise . interpretHttpNativeWith =<< runT (handler (convertResponse response))
    Http.ConsumeChunk body ->
      pureT =<< convertError <$> embed (try body)
      where
        convertError (Left (e :: SomeException)) =
          Left (HttpError.ChunkFailed (show e))
        convertError (Right a) =
          Right a
{-# INLINE interpretHttpNativeWith #-}

interpretHttpNative ::
  Members [Embed IO, Log, Resource] r =>
  InterpreterFor (Http BodyReader) r
interpretHttpNative =
  interpretManager . interpretHttpNativeWith . raiseUnder
{-# INLINE interpretHttpNative #-}
