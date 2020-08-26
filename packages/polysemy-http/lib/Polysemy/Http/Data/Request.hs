module Polysemy.Http.Data.Request where

import Control.Lens (makeClassy)
import qualified Data.Text as Text

import Polysemy.Http.Data.Header (HeaderName, HeaderValue)

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

methodUpper :: Method -> Text
methodUpper = \case
  Custom n -> Text.toUpper n
  a -> Text.toUpper (show a)

newtype Host =
  Host { unHost :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

newtype Port =
  Port { unPort :: Int }
  deriving (Eq, Show)

newtype Tls =
  Tls { unTls :: Bool }
  deriving (Eq, Show)

newtype Path =
  Path { unPath :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

newtype QueryKey =
  QueryKey { unQueryKey :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

newtype QueryValue =
  QueryValue { unQueryValue :: Text }
  deriving (Eq, Show)
  deriving newtype (IsString)

newtype Body =
  Body { unBody :: LByteString }
  deriving (Eq, Show)
  deriving newtype (IsString)

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
