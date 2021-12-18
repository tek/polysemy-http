module Polysemy.Http.CookieTest where

import Control.Lens ((.~))
import Hedgehog (evalEither, (===))
import Polysemy (embedToFinal, runFinal)
import Polysemy.Log (interpretLogNull)
import Polysemy.Resource (resourceToIOFinal)

import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Port(Port), Tls(Tls))
import qualified Polysemy.Http.Data.Response as Response
import Polysemy.Http.Data.Response (Response)
import Polysemy.Http.Interpreter.Native (interpretHttpNative)
import qualified Polysemy.Http.Request as Request
import Polysemy.Http.Request (addCookie)
import Polysemy.Http.Server (withServer)
import Polysemy.Http.Test (UnitTest)

c1, c1v, c2, c2v :: Text
c1 = "c1"
c1v = "c1v"
c2 = "c2"
c2v = "c2v"

runRequest ::
  Int ->
  IO (Either HttpError (Response LByteString))
runRequest port = do
  runFinal $ resourceToIOFinal $ embedToFinal $ interpretLogNull $ interpretHttpNative (Http.request request)
  where
  request =
    Request.get "localhost" "cookie"
    & Request.tls .~ Tls False
    & Request.port .~ Just (Port port)
    & addCookie "localhost" c2 c2v
    & addCookie "localhost" c1 c1v

test_cookies :: UnitTest
test_cookies = do
  result <- lift (withServer runRequest)
  response <- evalEither result
  [exon|#{c1}=#{c1v};#{c2}=#{c2v}|] === decodeUtf8 (Response._body response)
