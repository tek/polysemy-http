module Main where

import Test.Tasty (TestTree, defaultMain, testGroup)

import Polysemy.Http.RequestTest (test_request)
import Polysemy.Http.StreamTest (test_httpStream)
import Polysemy.Http.Test (unitTest)

tests :: TestTree
tests =
  testGroup "integration" [
    unitTest "simple request" test_request,
    unitTest "streaming http response handler" test_httpStream
  ]

main :: IO ()
main =
  defaultMain tests
