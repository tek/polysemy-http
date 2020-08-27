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

The higher-order constructor `Http.stream` opens and closes the request
manually and passes the response to a handler function.
The function `streamResponse` provides a simpler interface for this mechanism
that runs a loop that passes individual chunks produced by [http-client] to
a callback handler of type `∀ x . StreamEvent r c h x -> Sem r x` that should
look like this:

```haskell
handle ::
  StreamEvent Double (IO ByteString) Int a ->
  Sem r a
handle = \case
  StreamEvent.Acquire (Response status body headers) ->
    pure 1
  StreamEvent.Chunk handle (StreamChunk c) ->
    pure ()
  StreamEvent.Result (Response status body headers) handle ->
    pure 5.5
  StreamEvent.Release handle ->
    pure ()

run :: Sem r Double
run =
  Http.streamResponse (Request.get "host.com" "path/to/file") handle
```

If you were e.g. to write the data to disk, you would open the file in the
`Acquire` block, write the `ByteString` `c` in `Chunk`, and close the file in
`Release`.
The parameter `h` could then be `Handle`.
The callbacks are wrapped in `Resource.bracket`, so `Release` is guaranteed to
be called (as much as `Resource` is reliable).
The `Result` block is called when the transfer is complete; its returned value
is finally returned from `streamHandler.`
The `handle` is an arbitrary identifier that the user can return from
`Acquire`; it is not needed for the machinery and may be `()`.

# Entity

The library also provides effects for request and response entity de/encoding,
`EntityDecode d m a` and `EntityEncode d m a`, making it possible to abstract
over json implementations or content types using interpreters.
Since the effects are parameterized by the codec data type, one interpreter per
type must be used.

Implementations for [aeson] are available as `interpretEntityDecodeAeson` and
`interpretEntityEncodeAeson`:

```haskell
import Polysemy (run)
import qualified Polysemy.Http as Http
import Polysemy.Http (interpretEntityDecodeAeson)

data Dat { a :: Maybe Int, b :: Text }
deriving (Show, FromJSON)

main :: IO
main =
  print $ run $ interpretEntityDecodeAeson $ Http.decode "{ \"b\": \"hello\" }"
```

There is not integration with the `Http` effect for this.

# Testing

Polysemy makes it very easy to switch the native interpreter for a mock, and
there is a convenience interpreter named `interpretHttpStrict` that allows you
to specify a list of responses and chunks that should be produced:

```haskell
main :: IO ()
main = do
  result <- runM $
    resourceToIO $
    interpretLogStdout $
    interpretHttpStrict [Response (toEnum 200) "foo" []] [] $
    Http.request (Http.get "hackage.haskell.org" "package/polysemy-http")
  print result
```

[Polysemy]: https://hackage.haskell.org/package/polysemy
[http-client]: https://hackage.haskell.org/package/http-client
[http-types]: https://hackage.haskell.org/package/http-types
[aeson]: https://hackage.haskell.org/package/aeson
