module Main where

import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.Hedgehog (testProperty)

import UrlTest (test_urlRE)

tests :: TestTree
tests =
  testGroup "all" [
    testProperty "url regex" test_urlRE
    ]

main :: IO ()
main =
  defaultMain tests
