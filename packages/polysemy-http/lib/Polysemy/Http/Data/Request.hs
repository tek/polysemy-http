{-# options_haddock prune #-}

-- |Description: Request Data Types, Internal
module Polysemy.Http.Data.Request where

import qualified Data.Text as Text
import Network.HTTP.Client.Internal (CookieJar)

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
  deriving stock (Eq, Show)

json ''Method

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
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

json ''Host

-- |Request port.
newtype Port =
  Port { unPort :: Int }
  deriving stock (Eq, Show, Generic)
  deriving newtype (Num, Ord, Enum, Real, Integral, Read)

json ''Port

-- |A flag that indicates whether a request should use TLS.
newtype Tls =
  Tls { unTls :: Bool }
  deriving stock (Eq, Show, Generic)

json ''Tls

-- |Rrequest path.
newtype Path =
  Path { unPath :: Text }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString, Monoid)

instance Semigroup Path where
  "" <> r =
    r
  l <> "" =
    l
  Path l <> Path r =
    Path (Text.dropWhileEnd ('/' ==) l <> "/" <> Text.dropWhile ('/' ==) r)

json ''Path

-- |The key of a query parameter.
newtype QueryKey =
  QueryKey { unQueryKey :: Text }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

json ''QueryKey

-- |The value of a query parameter.
newtype QueryValue =
  QueryValue { unQueryValue :: Text }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

json ''QueryValue

-- |Request body.
newtype Body =
  Body { unBody :: ByteString }
  deriving stock (Eq, Show, Generic)
  deriving newtype (IsString)

-- |HTTP request parameters, used by 'Polysemy.Http.Effect.Http'.
data Request =
  Request {
    method :: Method,
    host :: Host,
    port :: Maybe Port,
    tls :: Tls,
    path :: Path,
    headers :: [(HeaderName, HeaderValue)],
    cookies :: CookieJar,
    query :: [(QueryKey, Maybe QueryValue)],
    body :: Body
  }
  deriving stock (Show, Generic)

instance Eq Request where
  Request lm lh lp lt lpa lhe _ lq lb == Request rm rh rp rt rpa rhe _ rq rb =
    lm == rm && lh == rh && lp == rp && lt == rt && lpa == rpa && lhe == rhe && lq == rq && lb == rb
