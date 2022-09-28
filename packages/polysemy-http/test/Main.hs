module Main where

import Polysemy.Http.ResponseTest (test_statusPattern)
import Polysemy.Http.Test (unitTest)
import Polysemy.Http.UrlTest (test_url)
import Test.Tasty (TestTree, defaultMain, testGroup)

tests :: TestTree
tests =
  testGroup "unit" [
    unitTest "url parser" test_url,
    unitTest "status pattern" test_statusPattern
    ]

main :: IO ()
main =
  defaultMain tests
