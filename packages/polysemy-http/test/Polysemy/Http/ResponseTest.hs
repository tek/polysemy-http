module Polysemy.Http.ResponseTest where

import Hedgehog ((===))

import qualified Polysemy.Http.Data.Response as Response
import Polysemy.Http.Data.Response (Response(Response))
import Polysemy.Http.Test (UnitTest)

response :: Response ()
response =
  Response (toEnum 404) () []

match :: Response a -> Int
match = \case
  Response.Success _ _ _ -> 0
  Response.Client _ _ _ -> 1
  _ -> 2

test_statusPattern :: UnitTest
test_statusPattern =
  1 === match response
