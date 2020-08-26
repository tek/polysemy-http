# About

This Haskell library provides a [Polysemy] effect for running HTTP requests with [http-client].

# Example

```haskell
import Polysemy (runM, resourceToIO)
import qualified Polysemy.Http as Http
import Polysemy.Http (interpretHttpNative, interpretLogStdout)

main :: IO ()
main = do
  result <- runM $
    resourceToIO $
    interpretLogStdout $
    interpretHttpNative $
    Http.request (Http.get "hackage.haskell.org" "package/polysemy-http")
  print result
```

# API

# Streaming

[Polysemy]: https://hackage.haskell.org/package/polysemy
[http-client]: https://hackage.haskell.org/package/http-client
