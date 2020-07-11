module ResponseTest where

import Hedgehog (Property, property, (===))

import qualified Polysemy.Http.Data.Response as Response
import Polysemy.Http.Data.Response (Response(Response))

response :: Response ()
response =
  Response 404 () []

match :: Response a -> Int
match = \case
  Response.Success _ _ _ -> 0
  Response.Client _ _ _ -> 1
  _ -> 2

test_statusPattern :: Property
test_statusPattern =
  property $ 1 === match response
