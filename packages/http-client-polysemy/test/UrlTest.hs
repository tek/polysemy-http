module UrlTest where

import Hedgehog (Property, property, (===))

import Polysemy.Http.Data.Request (parseUrl)

test_urlRE :: Property
test_urlRE =
  property $ (Right ("host.com", "path")) === (parseUrl "https://host.com/path")
