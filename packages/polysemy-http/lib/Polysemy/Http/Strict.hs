module Polysemy.Http.Strict where

import Polysemy (interpretH, pureT)
import Polysemy.Internal.Tactics hiding (liftT)

import Polysemy.Http.Data.Header (Header(Header))
import qualified Polysemy.Http.Data.Http as Http
import Polysemy.Http.Data.Http (Http)
import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Response (Response(Response))

takeResponse ::
  Member (State [Response LByteString]) r =>
  [Response LByteString] ->
  Sem r (Either a (Response LByteString))
takeResponse (response : rest) =
  Right response <$ put rest
takeResponse [] =
  pure (Right (Response (toEnum 502) "test responses exhausted" []))

takeChunk ::
  Member (State [ByteString]) r =>
  [ByteString] ->
  Sem r ByteString
takeChunk (chunk : rest) =
  chunk <$ put rest
takeChunk [] =
  pure ""

streamResponse :: Response Int
streamResponse =
  Response (toEnum 200) 1 [
    Header "content-disposition" [qt|filename="file.txt"|],
    Header "content-length" "5000000"
    ]

interpretHttpStrictWithState ::
  Members [State [ByteString], State [Response LByteString], Embed IO] r =>
  InterpreterFor (Http Int) r
interpretHttpStrictWithState =
  interpretH $ \case
    Http.Request _ ->
      liftT . takeResponse =<< raise get
    Http.Stream _ handler -> do
      handle <- bindT handler
      resp <- pureT streamResponse
      raise (interpretHttpStrictWithState (handle resp))
    Http.ConsumeChunk _ ->
      liftT . fmap Right . takeChunk =<< raise get
{-# INLINE interpretHttpStrictWithState #-}

-- |In-Memory interpreter for 'Http'.
-- The first parameter is a list of 'Response'. When a request is made, one response is popped of the head and returned.
-- If the list is exhausted, a 502 response is returned.
interpretHttpStrict ::
  Member (Embed IO) r =>
  [Response LByteString] ->
  [ByteString] ->
  InterpreterFor (Http Int) r
interpretHttpStrict responses chunks =
  evalState chunks .
  evalState responses .
  interpretHttpStrictWithState .
  raiseUnder .
  raiseUnder
{-# INLINE interpretHttpStrict #-}
