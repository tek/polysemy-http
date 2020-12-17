module Polysemy.Http.Data.Http where

import Polysemy (makeSem_)

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

-- |The main effect for HTTP requests.
-- The parameter @c@ determines the representation of raw chunks.
data Http c :: Effect where
  Response :: Request -> (Response c -> m a) -> Http c m (Either HttpError a)
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  Stream :: Request -> (Response c -> m a) -> Http c m (Either HttpError a)
  -- |Internal action for streaming transfers.
  ConsumeChunk :: c -> Http c m (Either HttpError ByteString)

makeSem_ ''Http

-- |Bracket a higher-order action with a 'Response' that has been opened while its body hasn't been fetched.
response ::
  ∀ c r a .
  Member (Http c) r =>
  Request ->
  (Response c -> Sem r a) ->
  Sem r (Either HttpError a)

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
  (Response c -> Sem r a) ->
  Sem r (Either HttpError a)

consumeChunk ::
  ∀ c r .
  Member (Http c) r =>
  c ->
  Sem r (Either HttpError ByteString)
