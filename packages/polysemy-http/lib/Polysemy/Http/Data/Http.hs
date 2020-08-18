module Polysemy.Http.Data.Http where

import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

data Http c m a where
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  Stream :: Request -> (Response c -> m (Either HttpError a)) -> Http c m (Either HttpError a)
  ConsumeChunk :: c -> Http c m (Either HttpError ByteString)

makeSem ''Http
