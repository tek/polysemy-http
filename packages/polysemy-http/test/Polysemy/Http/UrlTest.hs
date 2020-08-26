module Polysemy.Http.UrlTest where

import Hedgehog ((===))

import Polysemy.Http.Data.Request (parseUrl)
import Polysemy.Http.Test (UnitTest)

test_urlRE :: UnitTest
test_urlRE =
  Right ("host.com", "path") === parseUrl "https://host.com/path"
