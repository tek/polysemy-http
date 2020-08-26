module Polysemy.Http.Server where

import Control.Concurrent (ThreadId, forkIO, killThread)
import Control.Exception (bracket)
import qualified Data.Text as Text
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Network.Socket (
  PortNumber,
  addrAddress,
  addrFamily,
  addrProtocol,
  addrSocketType,
  bind,
  close,
  defaultHints,
  getAddrInfo,
  socket,
  socketPort,
  withSocketsDo,
  )
import qualified Network.Wai.Handler.Warp as Warp
import Servant (Get, Handler, JSON, PlainText, Post, ReqBody, ServerT, serve, (:<|>)((:<|>)), (:>))
import Servant.Client (BaseUrl(BaseUrl), Client, ClientEnv, ClientM, Scheme(Http), client, mkClientEnv, runClientM)

freePort ::
  IO PortNumber
freePort =
  withSocketsDo $ do
    addr : _ <- getAddrInfo (Just defaultHints) (Just "127.0.0.1") (Just "0")
    bracket (open addr) close socketPort
  where
    open addr = do
      sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
      bind sock (addrAddress addr)
      return sock

data Payload =
  Payload {
    one :: Int,
    two :: Int
  }
  deriving (Eq, Show)

defaultJson ''Payload

type Api =
  Get '[JSON] Text
  :<|>
  "add" :> ReqBody '[JSON] Payload :> Post '[JSON] Int
  :<|>
  "stream" :> Get '[PlainText] Text

apiClient :: Client ClientM Api
apiClient =
  client (Proxy @Api)

check :: ClientM Text
check :<|> _ =
  apiClient

clientEnv ::
  BaseUrl ->
  IO ClientEnv
clientEnv baseUrl =
  flip mkClientEnv baseUrl <$> newManager defaultManagerSettings

server :: ServerT Api Handler
server =
  pure "OK"
  :<|>
  (\ (Payload a b) -> pure (a + b))
  :<|>
  pure (Text.replicate (10 * 8192) "x")

forkServer :: IO (ThreadId, Int)
forkServer = do
  port <- fromIntegral <$> freePort
  threadId <- forkIO (Warp.run port (serve (Proxy @Api) server))
  env <- clientEnv (BaseUrl Http "localhost" port "")
  runClientM check env
  pure (threadId, port)

withServer :: (Int -> IO a) -> IO a
withServer use =
  bracket forkServer (killThread . fst) (use . snd)
