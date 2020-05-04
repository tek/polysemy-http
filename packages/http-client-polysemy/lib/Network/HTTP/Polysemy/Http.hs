module Network.HTTP.Polysemy.Http where

import Control.Lens (over)
import qualified Data.ByteString as ByteString
import Polysemy.Error (fromEither, runError)
import Polysemy.Resource (Resource, bracket)

import Network.HTTP.Polysemy.Data.Http (Http)
import qualified Network.HTTP.Polysemy.Data.Http as Http
import Network.HTTP.Polysemy.Data.HttpError (HttpError)
import Network.HTTP.Polysemy.Data.Request (Request)
import qualified Network.HTTP.Polysemy.Data.Request as Request
import Network.HTTP.Polysemy.Data.Response (Response(Response))
import Network.HTTP.Polysemy.Data.StreamChunk (StreamChunk(StreamChunk))
import Network.HTTP.Polysemy.Data.StreamEvent (StreamEvent)
import qualified Network.HTTP.Polysemy.Data.StreamEvent as StreamEvent

jsonContentType :: (Text, Text)
jsonContentType =
  ("content-type", "application/json")

jsonRequest ::
  Member (Http c) r =>
  Request ->
  Sem r (Either HttpError (Response LByteString))
jsonRequest =
  Http.request . over Request.headers (jsonContentType :)

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
    handleChunk chunk =
      process (StreamEvent.Chunk handle (StreamChunk chunk)) *> spin

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

streamResponse ::
  Members [Http c, Error HttpError, Resource] r =>
  Request ->
  (∀ x . StreamEvent o c h x -> Sem r (Either HttpError x)) ->
  Sem r o
streamResponse request process =
  fromEither =<< Http.stream request (runError . streamHandler (fromEither <=< raise . process))
