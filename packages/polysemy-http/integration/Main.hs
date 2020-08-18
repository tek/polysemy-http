module Main where

import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.Hedgehog (testProperty)

import StreamTest (test_httpStream)

tests :: TestTree
tests =
  testGroup "all" [
    testProperty "streaming http response handler" test_httpStream
    ]

main :: IO ()
main =
  defaultMain tests
