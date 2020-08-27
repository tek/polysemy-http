module Polysemy.Http.Data.Http where

import Polysemy (makeSem_)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

-- |The main effect for HTTP requests.
-- The parameter @c@ determines the representation of raw chunks.
data Http c :: Effect where
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  Stream :: Request -> (Response c -> m (Either HttpError a)) -> Http c m (Either HttpError a)
  -- |Internal effect for streaming transfers.
  ConsumeChunk :: c -> Http c m (Either HttpError ByteString)

makeSem_ ''Http

-- |Synchronously run an HTTP request and return the response.
request ::
  ∀ c r .
  Member (Http c) r =>
  Request ->
  Sem r (Either HttpError (Response LByteString))

-- |Open a connection without consuming data and pass the response to a handler for custom transmission.
-- The intended purpose is to allow streaming transfers.
stream ::
  ∀ c r a .
  Member (Http c) r =>
  Request ->
  (Response c -> Sem r (Either HttpError a)) ->
  Sem r (Either HttpError a)

consumeChunk ::
  ∀ c r .
  Member (Http c) r =>
  c ->
  Sem r (Either HttpError ByteString)
