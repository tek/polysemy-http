module Polysemy.Http.Http where

import Control.Lens ((%~))
import qualified Data.ByteString as ByteString
import Polysemy.Resource (Resource, bracket)

import Polysemy.Http.Data.Header (HeaderName, HeaderValue)
import qualified Polysemy.Http.Data.Http as Http
import Polysemy.Http.Data.Http (Http)
import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response(Response))
import Polysemy.Http.Data.StreamChunk (StreamChunk(StreamChunk))
import qualified Polysemy.Http.Data.StreamEvent as StreamEvent
import Polysemy.Http.Data.StreamEvent (StreamEvent)

jsonContentType :: (HeaderName, HeaderValue)
jsonContentType =
  ("content-type", "application/json")

jsonRequest ::
  Member (Http c) r =>
  Request ->
  Sem r (Either HttpError (Response LByteString))
jsonRequest =
  Http.request . (Request.headers %~ (jsonContentType :))

streamLoop ::
  Members [Http c, Error HttpError] r =>
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Response c ->
  h ->
  Sem r o
streamLoop process response@(Response _ body _) handle =
  spin
  where
    spin =
      handleChunk =<< fromEither =<< Http.consumeChunk body
    handleChunk (ByteString.null -> True) =
      process (StreamEvent.Result response handle)
    handleChunk !chunk = do
      process (StreamEvent.Chunk handle (StreamChunk chunk))
      spin

streamHandler ::
  ∀ o r c h .
  Members [Http c, Error HttpError, Resource] r =>
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Response c ->
  Sem r o
streamHandler process response = do
  bracket acquire release (streamLoop process response)
  where
    acquire =
      process (StreamEvent.Acquire response)
    release handle =
      process (StreamEvent.Release handle)

-- |Initiate a request and stream the response, calling 'process' after connecting, for every chunk, after closing the
-- connection, and for the return value.
-- 'StreamEvent' is used to indicate the stage of the request cycle.
streamResponse ::
  Members [Http c, Error HttpError, Resource] r =>
  Request ->
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Sem r o
streamResponse request process =
  fromEither =<< Http.stream request (runError . streamHandler (raise . process))
