module Network.HTTP.Polysemy (
  interpretHttpNative,
  interpretHttpStrict,
) where

import Network.HTTP.Polysemy.Native (interpretHttpNative)
import Network.HTTP.Polysemy.Strict (interpretHttpStrict)
