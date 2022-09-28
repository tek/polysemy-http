module Polysemy.Http.StreamTest where

import qualified Data.ByteString as ByteString
import Hedgehog (assert, evalEither, (===))
import Log (interpretLogNull)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Port (Port), Request, Tls (Tls))
import Polysemy.Http.Data.StreamChunk (StreamChunk (StreamChunk))
import qualified Polysemy.Http.Data.StreamEvent as StreamEvent
import Polysemy.Http.Data.StreamEvent (StreamEvent)
import qualified Polysemy.Http.Http as Http
import Polysemy.Http.Interpreter.Native (interpretHttpNative)
import qualified Polysemy.Http.Request as Request
import Polysemy.Http.Server (withServer)
import Polysemy.Http.Test (UnitTest)

req :: Int -> Request
req port =
  Request.get "localhost" "stream"
  & #port .~ Just (Port port)
  & #tls .~ Tls False

handle ::
  Members [Embed IO, State [Int]] r =>
  StreamEvent () (IO ByteString) () a ->
  Sem r a
handle = \case
  StreamEvent.Acquire _ ->
    unit
  StreamEvent.Chunk _ (StreamChunk c) ->
    modify (ByteString.length c :)
  StreamEvent.Result _ _ ->
    unit
  StreamEvent.Release _ ->
    unit

runRequest ::
  Int ->
  IO (Either HttpError ([Int], ()))
runRequest port =
  runFinal $
  resourceToIOFinal $
  embedToFinal $
  runError @HttpError $
  runState empty $
  interpretLogNull $
  interpretHttpNative $
  Http.streamResponse (req port) (Just 8192) handle

test_httpStream :: UnitTest
test_httpStream = do
  result <- liftIO (withServer runRequest)
  (chunkSizes, ()) <- evalEither result
  assert (all (>= 8192) chunkSizes)
  sum chunkSizes === 10 * 8192
