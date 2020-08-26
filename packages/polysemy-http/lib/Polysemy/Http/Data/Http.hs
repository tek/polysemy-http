module Polysemy.Http.Data.Http where

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

-- |The main effect for HTTP requests.
-- The parameter @c@ determines the representation of raw chunks.
data Http c :: Effect where
  -- |Synchronously run an HTTP request and return the response.
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  -- |Open a connection without consuming data and pass the response to a handler for custom transmission.
  -- The intended purpose is to allow streaming transfers.
  Stream :: Request -> (Response c -> m (Either HttpError a)) -> Http c m (Either HttpError a)
  -- |Internal effect for streaming transfers.
  ConsumeChunk :: c -> Http c m (Either HttpError ByteString)

makeSem ''Http
