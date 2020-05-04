module StreamTest where

import qualified Data.Text as Text
import Hedgehog (Property, property, (===))
import Network.HTTP.Polysemy.Log (interpretLogStdout)
import Polysemy (embedToFinal, runFinal)
import Polysemy.Error (runError)
import Polysemy.Resource (resourceToIOFinal)
import Polysemy.State (runState)

import Network.HTTP.Polysemy.Data.HttpError (HttpError)
import Network.HTTP.Polysemy.Data.Request (Request)
import qualified Network.HTTP.Polysemy.Data.Request as Request
import Network.HTTP.Polysemy.Data.StreamChunk (StreamChunk(StreamChunk))
import Network.HTTP.Polysemy.Data.StreamEvent (StreamEvent)
import qualified Network.HTTP.Polysemy.Data.StreamEvent as StreamEvent
import qualified Network.HTTP.Polysemy.Http as Http
import Network.HTTP.Polysemy.Native (interpretHttpNative)

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
