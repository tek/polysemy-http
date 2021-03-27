module Main where

import Polysemy.Http.CookieTest (test_cookies)
import Polysemy.Http.RequestTest (test_request)
import Polysemy.Http.StreamTest (test_httpStream)
import Polysemy.Http.Test (unitTest)
import Test.Tasty (TestTree, defaultMain, testGroup)

tests :: TestTree
tests =
  testGroup "integration" [
    unitTest "simple request" test_request,
    unitTest "streaming http response handler" test_httpStream,
    unitTest "cookies" test_cookies
  ]

main :: IO ()
main =
  defaultMain tests
