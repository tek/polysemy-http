module StreamTest where

import qualified Data.Text as Text
import Hedgehog (Property, property, (===))
import Polysemy.Http.Log (interpretLogStdout)
import Polysemy (embedToFinal, runFinal)
import Polysemy.Error (runError)
import Polysemy.Resource (resourceToIOFinal)
import Polysemy.State (runState)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.StreamChunk (StreamChunk(StreamChunk))
import Polysemy.Http.Data.StreamEvent (StreamEvent)
import qualified Polysemy.Http.Data.StreamEvent as StreamEvent
import qualified Polysemy.Http.Http as Http
import Polysemy.Http.Native (interpretHttpNative)

req :: Request
req =
  Request.get "tryp.io" "text"

handle ::
  Members [Embed IO, State Int] r =>
  StreamEvent () (IO ByteString) () a ->
  Sem r (Either HttpError a)
handle (StreamEvent.Acquire _) = do
  pure (Right ())
handle (StreamEvent.Chunk _ (StreamChunk chunk)) = do
  Right () <$ modify ((Text.length (decodeUtf8 chunk)) +)
handle (StreamEvent.Result _ _) = do
  pure (Right ())
handle (StreamEvent.Release _) = do
  pure (Right ())

test_httpStream :: Property
test_httpStream =
  property $ do
    r <-
      liftIO $
      runFinal @IO $
      embedToFinal @IO $
      resourceToIOFinal $
      runError @HttpError $
      runState 0 $
      interpretLogStdout $
      interpretHttpNative $
      Http.streamResponse req handle
    (Right (12000000, ())) === r
