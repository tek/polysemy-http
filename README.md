# About

This Haskell library provides a [Polysemy] effect for running HTTP requests.

# Usage

```haskell
import qualified Polysemy.Http.Data.Http as Http
import qualified Polysemy.Http.Data.Request as Request

main :: IO ()
main =
  interpretHttpNative $
  Http.Request (Request.get "hackage.haskell.org" "package/polysemy-http")
```
