module Network.HTTP.Polysemy.Log where

import Colog.Core (LogAction(LogAction), Severity, cmapM)
import qualified Colog.Core as Severity (Severity(Error, Info, Debug, Warning))
import qualified Colog.Polysemy as Colog (Log, log)
import Colog.Polysemy.Effect (runLogAction)
import qualified Data.ByteString.Char8 as BS8
import GHC.Stack (SrcLoc(SrcLoc), callStack, popCallStack, srcLocModule, srcLocStartLine)
import System.Console.ANSI (Color (..), ColorIntensity (Vivid), ConsoleLayer (Foreground), SGR (..), setSGRCode)

import Network.HTTP.Polysemy.Data.Log (Log(..))

data Message =
  Message {
    msgSeverity :: !Severity,
    msgStack :: !CallStack,
    msgText :: !Text
  }

showSeverity :: Severity -> Text
showSeverity = \case
  Severity.Debug -> color Green "[Debug]   "
  Severity.Info -> color Blue "[Info]    "
  Severity.Warning -> color Yellow "[Warning] "
  Severity.Error -> color Red "[Error]   "
 where
   color :: Color -> Text -> Text
   color c txt =
     toText (setSGRCode [SetColor Foreground Vivid c]) <>
     txt <>
     toText (setSGRCode [Reset])

showSourceLoc :: CallStack -> Text
showSourceLoc cs =
  square showCallStack
  where
    showCallStack :: Text
    showCallStack = case getCallStack cs of
      [] -> "<unknown loc>"
      [(name, loc)] -> showLoc name loc
      (_, loc) : (callerName, _) : _ -> showLoc callerName loc
    square t = "[" <> t <> "] "
    showLoc :: String -> SrcLoc -> Text
    showLoc name SrcLoc{..} =
      toText srcLocModule <> "." <> toText name <> "#" <> show srcLocStartLine

fmtRichMessageDefault :: Message -> IO Text
fmtRichMessageDefault =
  pure . formatRichMessage
  where
    formatRichMessage :: Message -> Text
    formatRichMessage Message{..} =
        showSeverity msgSeverity
     <> showSourceLoc msgStack
     <> msgText

logByteStringStdout :: LogAction IO ByteString
logByteStringStdout = LogAction BS8.putStrLn

richMessageAction :: LogAction IO Message
richMessageAction =
    cmapM (fmap encodeUtf8 . fmtRichMessageDefault) logByteStringStdout
{-# INLINE richMessageAction #-}

log ::
  HasCallStack =>
  Member (Colog.Log Message) r =>
  Severity ->
  Text ->
  Sem r ()
log severity text =
  Colog.log (Message severity stack text)
  where
    stack =
      popCallStack (popCallStack callStack)

interpretLogNull ::
  InterpreterFor Log r
interpretLogNull =
  interpret $ \case
    Debug _ -> unit
    Info _ -> unit
    Warn _ -> unit
    Error _ -> unit
    ErrorPlus _ _ -> unit

runCologStdout ::
  Member (Embed IO) r =>
  InterpreterFor (Colog.Log Message) r
runCologStdout =
  runLogAction @IO richMessageAction

toColog ::
  HasCallStack =>
  Member (Colog.Log Message) r =>
  Sem (Log : r) a ->
  Sem r a
toColog =
  interpret $ \case
    Debug msg ->
      log Severity.Debug msg
    Info msg ->
      log Severity.Info msg
    Warn msg ->
      log Severity.Warning msg
    Error msg ->
      log Severity.Error msg
    ErrorPlus msg detailed ->
      log Severity.Error msg *> traverse_ (log Severity.Debug) detailed

interpretLogStdout ::
  Member (Embed IO) r =>
  Sem (Log : r) a ->
  Sem r a
interpretLogStdout =
  runCologStdout . toColog . raiseUnder
