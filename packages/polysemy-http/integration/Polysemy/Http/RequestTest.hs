module Polysemy.Http.RequestTest where

import qualified Data.Aeson as Aeson
import Hedgehog (evalEither, (===))
import Log (interpretLogNull)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Body (Body), Port (Port), Tls (Tls))
import Polysemy.Http.Data.Response (Response)
import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Interpreter.Native (interpretHttpNative)
import Polysemy.Http.Json (jsonContentType)
import qualified Polysemy.Http.Request as Request
import Polysemy.Http.Server (Payload (Payload), withServer)
import Polysemy.Http.Test (UnitTest)

runRequest ::
  Int ->
  IO (Either HttpError (Response LByteString))
runRequest port = do
  runFinal $ resourceToIOFinal $ embedToFinal $ interpretLogNull $ interpretHttpNative (Http.request request)
  where
  request =
    Request.post "localhost" "add" (Body (toStrict (Aeson.encode (Payload 2 3))))
    & #tls .~ Tls False
    & #port .~ Just (Port port)
    & #headers .~ [jsonContentType]

test_request :: UnitTest
test_request = do
  result <- liftIO (withServer runRequest)
  response <- evalEither result
  "5" === response ^. #body
