module Polysemy.Http.RequestTest where

import Control.Lens ((.~))
import qualified Data.Aeson as Aeson
import Hedgehog (evalEither, (===))
import Polysemy (embedToFinal, runFinal)
import Polysemy.Log (interpretLogNull)
import Polysemy.Resource (resourceToIOFinal)

import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Body(Body), Port(Port), Tls(Tls))
import qualified Polysemy.Http.Data.Response as Response
import Polysemy.Http.Data.Response (Response)
import Polysemy.Http.Json (jsonContentType)
import Polysemy.Http.Interpreter.Native (interpretHttpNative)
import qualified Polysemy.Http.Request as Request
import Polysemy.Http.Server (Payload(Payload), withServer)
import Polysemy.Http.Test (UnitTest)

runRequest ::
  Int ->
  IO (Either HttpError (Response LByteString))
runRequest port = do
  runFinal $ resourceToIOFinal $ embedToFinal $ interpretLogNull $ interpretHttpNative (Http.request request)
  where
  request =
    Request.post "localhost" "add" (Body (Aeson.encode (Payload 2 3)))
    & Request.tls .~ Tls False
    & Request.port .~ Just (Port port)
    & Request.headers .~ [jsonContentType]

test_request :: UnitTest
test_request = do
  result <- lift (withServer runRequest)
  response <- evalEither result
  "5" === Response._body response
