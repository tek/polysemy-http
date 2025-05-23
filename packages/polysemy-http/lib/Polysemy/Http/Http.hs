{-# options_haddock prune #-}

-- |Description: Streaming Implementation, Internal
module Polysemy.Http.Http where

import qualified Data.ByteString as ByteString

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response (Response))
import Polysemy.Http.Data.StreamChunk (StreamChunk (StreamChunk))
import qualified Polysemy.Http.Data.StreamEvent as StreamEvent
import Polysemy.Http.Data.StreamEvent (StreamEvent)
import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Effect.Http (Http)

streamLoop ::
  Members [Http c, Error HttpError] r =>
  Maybe Int ->
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Response c ->
  h ->
  Sem r o
streamLoop chunkSize process response@(Response _ body _ _) handle =
  spin
  where
    spin =
      handleChunk =<< fromEither =<< Http.consumeChunk chunkSize body
    handleChunk (ByteString.null -> True) =
      process (StreamEvent.Result response handle)
    handleChunk !chunk = do
      process (StreamEvent.Chunk handle (StreamChunk chunk))
      spin

streamHandler ::
  ∀ o r c h .
  Members [Http c, Error HttpError, Resource] r =>
  Maybe Int ->
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Response c ->
  Sem r o
streamHandler chunkSize process response =
  bracket acquire release (streamLoop chunkSize process response)
  where
    acquire =
      process (StreamEvent.Acquire response)
    release handle =
      process (StreamEvent.Release handle)

-- |Initiate a request and stream the response, calling @process@ after connecting, for every chunk, after closing the
-- connection, and for the return value.
-- 'StreamEvent' is used to indicate the stage of the request cycle.
-- The optional 'Int' argument defines the minimal chunk size that is read for each callback. If it is 'Nothing', the
-- stream reads what is available.
--
-- @
-- handle ::
--   StreamEvent Double (IO ByteString) Int a ->
--   Sem r a
-- handle = \\case
--   StreamEvent.Acquire (Response status body headers) ->
--     pure 1
--   StreamEvent.Chunk handle (StreamChunk c) ->
--     pure ()
--   StreamEvent.Result (Response status body headers) handle ->
--     pure 5.5
--   StreamEvent.Release handle ->
--     pure ()
-- @
-- >>> runInterpreters $ streamResponse (Http.get "host.com" "path/to/file") handle
-- 5.5
streamResponse ::
  Members [Http c, Error HttpError, Resource] r =>
  Request ->
  Maybe Int ->
  (∀ x . StreamEvent o c h x -> Sem r x) ->
  Sem r o
streamResponse request chunkSize process =
  fromEither . join =<< Http.response request (runError . streamHandler chunkSize (raise . process))
