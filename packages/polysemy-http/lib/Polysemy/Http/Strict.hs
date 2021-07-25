module Polysemy.Http.Strict where

import Polysemy (interpretH)
import Polysemy.Internal.Tactics (bindT, bindTSimple)

import Polysemy.Http.Data.Header (Header(Header))
import qualified Polysemy.Http.Data.Http as Http
import Polysemy.Http.Data.Http (Http)
import Polysemy.Http.Data.Response (Response(Response))
import Network.HTTP.Client.Internal (CookieJar(CJ))

takeResponse ::
  Member (State [Response LByteString]) r =>
  [Response LByteString] ->
  Sem r (Response LByteString)
takeResponse (response : rest) =
  response <$ put rest
takeResponse [] =
  pure (Response (toEnum 502) "test responses exhausted" [] (CJ mempty))

takeChunk ::
  Member (State [ByteString]) r =>
  [ByteString] ->
  Sem r ByteString
takeChunk (chunk : rest) =
  chunk <$ put rest
takeChunk [] =
  pure ""

streamResponse :: Response LByteString
streamResponse =
  Response (toEnum 200) "stream response" [
    Header "content-disposition" [qt|filename="file.txt"|],
    Header "content-length" "5000000"
    ] (CJ mempty)

interpretHttpStrictWithState ::
  Members [State [ByteString], State [Response LByteString], Embed IO] r =>
  InterpreterFor (Http LByteString) r
interpretHttpStrictWithState =
  interpretH \case
    Http.Response _ f -> do
      res <- liftT . takeResponse =<< raise get
      fmap Right <$> bindTSimple f res
    Http.Request _ ->
      liftT . fmap Right . takeResponse =<< raise get
    Http.Stream _ handler -> do
      handle <- bindT handler
      resp <- pureT streamResponse
      fmap Right <$> raise (interpretHttpStrictWithState (handle resp))
    Http.ConsumeChunk _ ->
      liftT . fmap Right . takeChunk =<< raise get
{-# inline interpretHttpStrictWithState #-}

-- |In-Memory interpreter for 'Http'.
interpretHttpStrict ::
  Member (Embed IO) r =>
  -- |When a request is made, one response is popped of the head and returned.
  --   If the list is exhausted, a 502 response is returned.
  [Response LByteString] ->
  -- |Chunks used for streaming responses.
  [ByteString] ->
  InterpreterFor (Http LByteString) r
interpretHttpStrict responses chunks =
  evalState chunks .
  evalState responses .
  interpretHttpStrictWithState .
  raiseUnder .
  raiseUnder
{-# inline interpretHttpStrict #-}
