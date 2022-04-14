{-# options_haddock prune #-}

-- |Description: Http Effect, Internal
module Polysemy.Http.Effect.Http where

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

-- |The main effect for HTTP requests.
-- The parameter @c@ determines the representation of raw chunks.
data Http c :: Effect where
  Response :: Request -> (Response c -> m a) -> Http c m (Either HttpError a)
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  -- |Internal action for streaming transfers.
  ConsumeChunk :: Maybe Int -> c -> Http c m (Either HttpError ByteString)

makeSem_ ''Http

-- |Bracket a higher-order action with a 'Polysemy.Http.Data.Response.Response' that has been opened while its body
-- hasn't been fetched.
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

-- |Consumes a chunk while streaming, with an optional chunk size.
consumeChunk ::
  ∀ c r .
  Member (Http c) r =>
  Maybe Int ->
  c ->
  Sem r (Either HttpError ByteString)
