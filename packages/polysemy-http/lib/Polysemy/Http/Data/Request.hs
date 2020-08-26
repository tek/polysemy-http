module Polysemy.Http.Data.Request where

import Control.Lens (makeClassy)
import Prelude hiding (get)
import Text.RE.PCRE.Text (RE, re, (=~))

data Method =
  Get
  |
  Post
  |
  Put
  |
  Head
  deriving (Eq, Show)

methodUpper :: Method -> Text
methodUpper Get = "GET"
methodUpper Post = "POST"
methodUpper Put = "PUT"
methodUpper Head = "HEAD"

data Request =
  Request {
    _method :: Method,
    _host :: Text,
    _port :: Maybe Int,
    _tls :: Bool,
    _path :: Text,
    _headers :: [(Text, Text)],
    _query :: [(Text, Text)],
    _body :: LByteString
  }
  deriving (Eq, Show)

makeClassy ''Request

urlRE :: RE
urlRE =
  [re|^(https://)?([^/]+)/(.*)|]

parseUrl :: Text -> Either Text (Text, Text)
parseUrl url =
  extract (url =~ urlRE :: (Text, Text, Text, [Text]))
  where
    extract (_, _, _, [_, host', path']) =
      Right (host', path')
    extract _ =
      Left [qt|invalid url: #{url}|]

get ::
  Text ->
  Text ->
  Request
get host' path' =
  Request Get host' Nothing True path' [] [] ""

post ::
  Text ->
  Text ->
  LByteString ->
  Request
post host' path' =
  Request Post host' Nothing True path' [] []

getUrl ::
  Text ->
  Either Text Request
getUrl url =
  uncurry get <$> parseUrl url
