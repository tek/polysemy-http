module Polysemy.Http.CookieTest where

import Exon (exon)
import Hedgehog (evalEither, (===))
import Log (interpretLogNull)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Port (Port), Tls (Tls))
import Polysemy.Http.Data.Response (Response)
import qualified Polysemy.Http.Effect.Http as Http
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
    & #tls .~ Tls False
    & #port .~ Just (Port port)
    & addCookie "localhost" c2 c2v
    & addCookie "localhost" c1 c1v

test_cookies :: UnitTest
test_cookies = do
  result <- liftIO (withServer runRequest)
  response <- evalEither result
  [exon|#{c1}=#{c1v};#{c2}=#{c2v}|] === decodeUtf8 (response ^. #body)
