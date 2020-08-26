module Main where

import Polysemy.Http.Test (unitTest)
import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.Hedgehog (testProperty)

import ResponseTest (test_statusPattern)
import UrlTest (test_urlRE)

tests :: TestTree
tests =
  testGroup "all" [
    unitTest "url regex" test_urlRE,
    unitTest "status pattern" test_statusPattern
    ]

main :: IO ()
main =
  defaultMain tests
