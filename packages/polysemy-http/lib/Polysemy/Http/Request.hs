module Polysemy.Http.Request where

import Control.Lens ((%~))
import qualified Data.Text as Text
import Data.Time (UTCTime(UTCTime))
import Network.HTTP.Client (Cookie(Cookie))
import Network.HTTP.Client.Internal (CookieJar(CJ, expose))
import Prelude hiding (get, put)

import Data.Time.Calendar (fromGregorian)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)
import qualified Polysemy.Http.Data.Request as Request
import Polysemy.Http.Data.Request (Body, Host(Host), Method(..), Path(Path), Port(Port), Request(Request), Tls(Tls))

invalidScheme ::
  Text ->
  Text ->
  Either Text a
invalidScheme scheme url =
  Left [qt|invalid scheme `#{scheme}` in url: #{url}|]

split ::
  Text ->
  Text ->
  (Text, Maybe Text)
split target t =
  case Text.breakOn target t of
    (a, "") -> (a, Nothing)
    (a, b) -> (a, Just (Text.drop (Text.length target) b))

parseScheme ::
  Text ->
  (Text, Maybe Text) ->
  Either Text (Tls, Text)
parseScheme url = \case
  (full, Nothing) -> Right (Tls True, full)
  ("https", Just rest) -> Right (Tls True, rest)
  ("http", Just rest) -> Right (Tls False, rest)
  (scheme, _) -> invalidScheme scheme url

parseHostPort ::
  Text ->
  (Text, Maybe Text) ->
  Either Text (Host, Maybe Port)
parseHostPort url = \case
  (host, Nothing) -> Right (Host host, Nothing)
  (host, Just (readMaybe . toString -> Just port)) -> Right (Host host, Just (Port port))
  (_, Just port) -> Left [qt|invalid port `#{port}` in url: #{url}|]

parseUrl ::
  Text ->
  Either Text (Tls, Host, Maybe Port, Path)
parseUrl url = do
  (tls, split "/" -> (hostPort, path)) <- parseScheme url (split "://" url)
  (host, port) <- parseHostPort url (split ":" hostPort)
  pure (tls, host, port, Path (fromMaybe "" path))

-- |Create a request with empty headers, query and cookies.
withPort ::
  Maybe Port ->
  Tls ->
  Method ->
  Host ->
  Path ->
  Body ->
  Request
withPort port tls method host path =
  Request method host port tls path [] (CJ []) []

-- |Create a request with default port and empty headers, query and cookies.
withTls ::
  Tls ->
  Method ->
  Host ->
  Path ->
  Body ->
  Request
withTls =
  withPort Nothing

-- |Create a TLS request with default port and empty headers, query and cookies.
simple ::
  Method ->
  Host ->
  Path ->
  Body ->
  Request
simple =
  withTls (Tls True)

-- |Create a TLS GET request with default port and empty headers, query and cookies.
get ::
  Host ->
  Path ->
  Request
get host path =
  simple Get host path ""

-- |Create a TLS POST request with default port and empty headers, query and cookies.
post ::
  Host ->
  Path ->
  Body ->
  Request
post host path =
  simple Post host path

-- |Create a TLS PUT request with default port and empty headers, query and cookies.
put ::
  Host ->
  Path ->
  Body ->
  Request
put host path =
  simple Put host path

-- |Create a TLS DELETE request with default port and empty headers, query and cookies.
delete ::
  Host ->
  Path ->
  Request
delete host path =
  simple Delete host path ""

-- |Parse the URL and create a request or return a parse error.
fromUrl ::
  Method ->
  Body ->
  Text ->
  Either Text Request
fromUrl method body url = do
  (tls, host, port, path) <- parseUrl url
  pure (withPort port tls method host path body)

-- |Parse URL for a GET.
getUrl ::
  Text ->
  Either Text Request
getUrl =
  fromUrl Get ""

-- |Parse URL for a POST.
postUrl ::
  Body ->
  Text ->
  Either Text Request
postUrl =
  fromUrl Post

-- |Parse URL for a PUT.
putUrl ::
  Body ->
  Text ->
  Either Text Request
putUrl =
  fromUrl Put

-- |Parse URL for a DELETE.
deleteUrl ::
  Text ->
  Either Text Request
deleteUrl =
  fromUrl Delete ""

neverExpire :: UTCTime
neverExpire =
  UTCTime (fromGregorian 9999 1 1) 0

epoch :: UTCTime
epoch =
  posixSecondsToUTCTime 0

-- |Create a cookie with default values.
cookie ::
  Text ->
  Text ->
  Text ->
  Cookie
cookie domain name value =
  Cookie (encodeUtf8 name) (encodeUtf8 value) neverExpire (encodeUtf8 domain) "/" epoch epoch False False False False

-- |Add multiple cookies to a request.
addCookies ::
  [Cookie] ->
  Request ->
  Request
addCookies cookies =
  Request.cookies %~ update
  where
    update =
      CJ . (cookies <>) . expose

-- |Add a cookie to a request, using default values.
addCookie ::
  Text ->
  Text ->
  Text ->
  Request ->
  Request
addCookie domain name value =
  addCookies (pure (cookie domain name value))
