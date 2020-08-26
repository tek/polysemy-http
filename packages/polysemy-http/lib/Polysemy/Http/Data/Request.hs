module Polysemy.Http.Data.Request where

import Control.Lens (makeClassy)
import qualified Data.Text as Text

import Polysemy.Http.Data.Header (HeaderName, HeaderValue)

-- |All standard HTTP methods, mirroring those from 'Network.HTTP.Types', plus a constructor for arbitrary strings.
data Method =
  Get
  |
  Post
  |
  Put
  |
  Delete
  |
  Head
  |
  Trace
  |
  Connect
  |
  Options
  |
  Patch
  |
  Custom Text
  deriving (Eq, Show)

instance IsString Method where
  fromString = \case
    "GET" -> Get
    "POST" -> Post
    "PUT" -> Put
    "DELETE" -> Delete
    "HEAD" -> Head
    "TRACE" -> Trace
    "CONNECT" -> Connect
    "OPTIONS" -> Options
    "PATCH" -> Patch
    "get" -> Get
    "post" -> Post
    "put" -> Put
    "delete" -> Delete
    "head" -> Head
    "trace" -> Trace
    "connect" -> Connect
    "options" -> Options
    "patch" -> Patch
    a -> Custom (toText a)

-- |Produce the usual uppercase representation of a method.
methodUpper :: Method -> Text
methodUpper = \case
  Custom n -> Text.toUpper n
  a -> Text.toUpper (show a)

-- |Request host name.
newtype Host =
  Host { unHost :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |Request port.
newtype Port =
  Port { unPort :: Int }
  deriving (Eq, Show)

-- |A flag that indicates whether a request should use TLS.
newtype Tls =
  Tls { unTls :: Bool }
  deriving (Eq, Show)

-- |Rrequest path.
newtype Path =
  Path { unPath :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |The key of a query parameter.
newtype QueryKey =
  QueryKey { unQueryKey :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |The value of a query parameter.
newtype QueryValue =
  QueryValue { unQueryValue :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |Request body, using 'LByteString' because it is what 'Aeson.encode' produces.
newtype Body =
  Body { unBody :: LByteString }
  deriving (Eq, Show)
  deriving newtype (IsString)

-- |HTTP request parameters, used by 'Polysemy.Http.Data.Http'.
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
  deriving (Eq, Show)

makeClassy ''Request
