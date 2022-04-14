{-# options_haddock prune #-}

-- |Description: Pure Http Interpreters, Internal
module Polysemy.Http.Interpreter.Pure where

import Network.HTTP.Client.Internal (CookieJar (CJ))
import Polysemy.Internal.Tactics (liftT)

import Polysemy.Http.Data.Response (Response (Response))
import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Effect.Http (Http)

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

interpretHttpPureWithState ::
  Members [State [ByteString], State [Response LByteString], Embed IO] r =>
  InterpreterFor (Http LByteString) r
interpretHttpPureWithState =
  interpretH \case
    Http.Response _ f -> do
      res <- liftT . takeResponse =<< raise get
      fmap Right <$> bindTSimple f res
    Http.Request _ ->
      liftT . fmap Right . takeResponse =<< raise get
    Http.ConsumeChunk _ _ ->
      liftT . fmap Right . takeChunk =<< raise get
{-# inline interpretHttpPureWithState #-}

-- |In-Memory interpreter for 'Http'.
interpretHttpPure ::
  Member (Embed IO) r =>
  -- |When a request is made, one response is popped of the list and returned.
  --   If the list is exhausted, a 502 response is returned.
  [Response LByteString] ->
  -- |Chunks used for streaming responses.
  [ByteString] ->
  InterpretersFor [Http LByteString, State [Response LByteString], State [ByteString]] r
interpretHttpPure responses chunks =
  evalState chunks .
  evalState responses .
  interpretHttpPureWithState
{-# inline interpretHttpPure #-}
