module UrlTest where

import Hedgehog (Property, property, (===))

import Network.HTTP.Polysemy.Data.Request (parseUrl)

test_urlRE :: Property
test_urlRE =
  property $ (Right ("host.com", "path")) === (parseUrl "https://host.com/path")
