module Polysemy.Http.StreamTest where

import Control.Lens ((.~))
import qualified Data.ByteString as ByteString
import Hedgehog (assert, evalEither, (===))
import Polysemy (embedToFinal, runFinal)
import Polysemy.Http.Log (interpretLogStdout)
import Polysemy.Resource (resourceToIOFinal)
import Polysemy.State (runState)

import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Port(Port), Request, Tls(Tls))
import Polysemy.Http.Data.StreamChunk (StreamChunk(StreamChunk))
import qualified Polysemy.Http.Data.StreamEvent as StreamEvent
import Polysemy.Http.Data.StreamEvent (StreamEvent)
import qualified Polysemy.Http.Http as Http
import Polysemy.Http.Native (interpretHttpNative)
import qualified Polysemy.Http.Request as Request
import Polysemy.Http.Server (withServer)
import Polysemy.Http.Test (UnitTest)

req :: Int -> Request
req port =
  Request.get "localhost" "stream"
  & Request.port .~ Just (Port port)
  & Request.tls .~ Tls False

handle ::
  Members [Embed IO, State [Int]] r =>
  StreamEvent () (IO ByteString) () a ->
  Sem r (Either HttpError a)
handle (StreamEvent.Acquire _) =
  pure (Right ())
handle (StreamEvent.Chunk _ (StreamChunk c)) =
  Right () <$ modify (ByteString.length c :)
handle (StreamEvent.Result _ _) =
  pure (Right ())
handle (StreamEvent.Release _) =
  pure (Right ())

runRequest ::
  Int ->
  IO (Either HttpError ([Int], ()))
runRequest port =
  runFinal $
  resourceToIOFinal $
  embedToFinal $
  runError @HttpError $
  runState empty $
  interpretLogStdout $
  interpretHttpNative $
  Http.streamResponse (req port) handle

test_httpStream :: UnitTest
test_httpStream = do
  result <- lift (withServer runRequest)
  (chunkSizes, ()) <- evalEither result
  assert (length chunkSizes >= 10)
  sum chunkSizes === 10 * 8192
