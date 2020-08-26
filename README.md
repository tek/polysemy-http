# About

This Haskell library provides a [Polysemy] effect for running HTTP requests
with [http-client].

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

## Request

The effect constructor `Http.request` takes an argument of type
`Polysemy.Http.Data.Request.Request`:

```haskell
data Request =
  Request {
    _method :: Method,
    _host :: Host,
    _port :: Maybe Port,
    _tls :: Tls,
    _path :: Path,
    _headers :: [(HeaderName, HeaderValue)],
    _query :: [(QueryKey, Maybe QueryValue)],
    _body :: Body
  }
```

Most of these fields are just newtypes, except for `Method`, which is an enum:

```haskell
data Method =
  Get | Post | ... | Custom Text
```

It has an `IsString` instance, so you can just write `"GET"` or `"delete"`.

All `Text` newtypes have `IsString` as well, and they will be converted to
`CI` and `ByteString` if needed when they are passed to [http-client].
`Body` is an `LByteString` newtype since that is what [aeson] typically
produces.
The port field is intended for nonstandard ports – if it is `Nothing`, the port
will be determined from `tls`.

## Response

`Http.request` returns `Either HttpError (Response LByteString)`, with
`Polysemy.Http.Data.Response.Response` looking like this:

```haskell
data Response b =
  Response {
    status :: Status,
    body :: b,
    headers :: [Header]
  }

data Header =
  Header {
    name :: HeaderName,
    value :: HeaderValue
  }
```

`Status` is from `http-types`, because it has some helpful combinators. Its
`Header` is just an alias, so this newtype is provided.
The parameter `b` is intended to allow you to write interpreters that produce
`Text` or something else, for example for [#testing].

# Streaming

# Entity

# Testing

[Polysemy]: https://hackage.haskell.org/package/polysemy
[http-client]: https://hackage.haskell.org/package/http-client
[http-types]: https://hackage.haskell.org/package/http-types
[aeson]: https://hackage.haskell.org/package/aeson
