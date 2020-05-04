module Network.HTTP.Polysemy.Data.Http where

import Network.HTTP.Polysemy.Data.HttpError (HttpError)
import Network.HTTP.Polysemy.Data.Request (Request)
import Network.HTTP.Polysemy.Data.Response (Response)

data Http c m a where
  Request :: Request -> Http c m (Either HttpError (Response LByteString))
  Stream :: Request -> (Response c -> m (Either HttpError a)) -> Http c m (Either HttpError a)
  ConsumeChunk :: c -> Http c m (Either HttpError ByteString)

makeSem ''Http
