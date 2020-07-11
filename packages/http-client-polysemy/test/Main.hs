module Main where

import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.Hedgehog (testProperty)

import ResponseTest (test_statusPattern)
import UrlTest (test_urlRE)

tests :: TestTree
tests =
  testGroup "all" [
    testProperty "url regex" test_urlRE,
    testProperty "status pattern" test_statusPattern
    ]

main :: IO ()
main =
  defaultMain tests
