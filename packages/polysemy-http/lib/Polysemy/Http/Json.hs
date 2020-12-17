module Polysemy.Http.Json where

import Control.Lens ((%~))

import Polysemy.Http.Data.Header (HeaderName, HeaderValue)
import qualified Polysemy.Http.Data.Http as Http
import Polysemy.Http.Data.Http (Http)
import Polysemy.Http.Data.HttpError (HttpError)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)

jsonContentType :: (HeaderName, HeaderValue)
jsonContentType =
  ("content-type", "application/json")

jsonRequest ::
  Member (Http res c) r =>
  Request ->
  Sem r (Either HttpError (Response LByteString))
jsonRequest =
  Http.request . (Request.headers %~ (jsonContentType :))
