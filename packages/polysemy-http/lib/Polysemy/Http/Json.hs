{-# options_haddock prune #-}

-- |Description: Json Request Combinator, Internal
module Polysemy.Http.Json where

import Polysemy.Http.Data.Header (HeaderName, HeaderValue)
import Polysemy.Http.Data.HttpError (HttpError)
import Polysemy.Http.Data.Request (Request)
import Polysemy.Http.Data.Response (Response)
import qualified Polysemy.Http.Effect.Http as Http
import Polysemy.Http.Effect.Http (Http)

jsonContentType :: (HeaderName, HeaderValue)
jsonContentType =
  ("content-type", "application/json")

-- |Make a request, setting the @content-type@ header to @application/json@
jsonRequest ::
  Member (Http c) r =>
  Request ->
  Sem r (Either HttpError (Response LByteString))
jsonRequest =
  Http.request . (#headers %~ (jsonContentType :))
