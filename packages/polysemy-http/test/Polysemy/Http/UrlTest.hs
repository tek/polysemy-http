module Polysemy.Http.UrlTest where

import Hedgehog ((===))

import Polysemy.Http.Data.Request (Host(Host), Path(Path), Port(Port), Tls(Tls))
import Polysemy.Http.Request (parseUrl)
import Polysemy.Http.Test (UnitTest)

test_url :: UnitTest
test_url = do
  Right (Tls True, Host "host.com", Nothing, Path "path") === parseUrl "https://host.com/path"
  Right (Tls True, Host "host.com", Nothing, Path "path/to/file") === parseUrl "host.com/path/to/file"
  Right (Tls False, Host "host.com", Just (Port 553), Path "path") === parseUrl "http://host.com:553/path"
  Left [qt|invalid port `foo` in url: #{url1}|] === parseUrl url1
  Left [qt|invalid scheme `httpx` in url: #{url2}|] === parseUrl url2
  where
    url1 =
      "http://host.com:foo"
    url2 =
      "httpx://host.com/path"
