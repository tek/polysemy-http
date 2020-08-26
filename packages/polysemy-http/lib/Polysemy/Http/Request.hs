module Polysemy.Http.Request where

import qualified Data.Text as Text
import Prelude hiding (get)

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

withPort ::
  Maybe Port ->
  Tls ->
  Method ->
  Host ->
  Path ->
  Body ->
  Request
withPort port tls method host path =
  Request method host port tls path [] []

withTls ::
  Tls ->
  Method ->
  Host ->
  Path ->
  Body ->
  Request
withTls =
  withPort Nothing

simple ::
  Method ->
  Host ->
  Path ->
  Body ->
  Request
simple =
  withTls (Tls True)

get ::
  Host ->
  Path ->
  Request
get host path =
  simple Get host path ""

post ::
  Host ->
  Path ->
  Body ->
  Request
post host path =
  simple Post host path

put ::
  Host ->
  Path ->
  Body ->
  Request
put host path =
  simple Put host path

delete ::
  Host ->
  Path ->
  Request
delete host path =
  simple Delete host path ""

fromUrl ::
  Method ->
  Body ->
  Text ->
  Either Text Request
fromUrl method body url = do
  (tls, host, port, path) <- parseUrl url
  pure (withPort port tls method host path body)

getUrl ::
  Text ->
  Either Text Request
getUrl =
  fromUrl Get ""

postUrl ::
  Body ->
  Text ->
  Either Text Request
postUrl =
  fromUrl Post

putUrl ::
  Body ->
  Text ->
  Either Text Request
putUrl =
  fromUrl Put

deleteUrl ::
  Text ->
  Either Text Request
deleteUrl =
  fromUrl Delete ""
