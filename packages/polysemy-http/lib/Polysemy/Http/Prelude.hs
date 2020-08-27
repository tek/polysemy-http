{-# LANGUAGE NoImplicitPrelude #-}

module Polysemy.Http.Prelude (
  module Polysemy.Http.Prelude,
  module Data.Aeson,
  module Data.Aeson.TH,
  module Data.Composition,
  module Data.Default,
  module Data.Either.Combinators,
  module Data.Foldable,
  module Data.Map.Strict,
  module GHC.Err,
  module Polysemy,
  module Polysemy.State,
  module Polysemy.Error,
  module Relude,
) where

import Control.Exception (try)
import Data.Aeson (FromJSON, ToJSON)
import Data.Aeson.TH (deriveFromJSON, deriveJSON)
import qualified Data.Aeson.TH as Aeson (Options, defaultOptions, unwrapUnaryRecords)
import Data.Composition ((.:))
import Data.Default (Default(def))
import Data.Either.Combinators (mapLeft)
import Data.Foldable (foldl, traverse_)
import Data.Map.Strict (Map)
import Data.String.Interpolate (i)
import GHC.Err (undefined)
import GHC.IO.Unsafe (unsafePerformIO)
import Language.Haskell.TH.Quote (QuasiQuoter)
import qualified Language.Haskell.TH.Syntax as TH
import Polysemy (
  Effect,
  Embed,
  InterpreterFor,
  Member,
  Members,
  Sem,
  WithTactics,
  embed,
  interpret,
  makeSem,
  pureT,
  raise,
  raiseUnder,
  raiseUnder2,
  raiseUnder3,
  )
import Polysemy.Error (Error, fromEither, runError, throw)
import Polysemy.State (State, evalState, get, gets, modify, put)
import Relude hiding (
  Reader,
  State,
  Type,
  ask,
  asks,
  evalState,
  get,
  gets,
  hoistEither,
  modify,
  put,
  readFile,
  runReader,
  runState,
  state,
  undefined,
  )

dbg :: Monad m => Text -> m ()
dbg msg = do
  () <- return $ unsafePerformIO (putStrLn (toString msg))
  return ()
{-# INLINE dbg #-}

dbgs :: Monad m => Show a => a -> m ()
dbgs a =
  dbg (show a)
{-# INLINE dbgs_ #-}

dbgs_ :: Monad m => Show a => a -> m a
dbgs_ a =
  a <$ dbg (show a)
{-# INLINE dbgs #-}

unit ::
  Applicative f =>
  f ()
unit =
  pure ()
{-# INLINE unit #-}

tuple ::
  Applicative f =>
  f a ->
  f b ->
  f (a, b)
tuple fa fb =
  (,) <$> fa <*> fb
{-# INLINE tuple #-}

unsafeLogSAnd :: Show a => a -> b -> b
unsafeLogSAnd a b =
  unsafePerformIO $ print a >> return b
{-# INLINE unsafeLogSAnd #-}

unsafeLogAnd :: Text -> b -> b
unsafeLogAnd a b =
  unsafePerformIO $ putStrLn (toString a) >> return b
{-# INLINE unsafeLogAnd #-}

unsafeLogS :: Show a => a -> a
unsafeLogS a =
  unsafePerformIO $ print a >> return a
{-# INLINE unsafeLogS #-}

qt :: QuasiQuoter
qt =
  i
{-# INLINE qt #-}

liftT ::
  forall m f r e a .
  Functor f =>
  Sem r a ->
  Sem (WithTactics e f m r) (f a)
liftT =
  pureT <=< raise
{-# INLINE liftT #-}

defaultOptions :: Aeson.Options
defaultOptions =
  Aeson.defaultOptions { Aeson.unwrapUnaryRecords = True }

hoistEither ::
  Member (Error e2) r =>
  (e1 -> e2) ->
  Either e1 a ->
  Sem r a
hoistEither f =
  fromEither . mapLeft f

tryAny ::
  Member (Embed IO) r =>
  IO a ->
  Sem r (Either Text a)
tryAny =
  embed . fmap (mapLeft show) . try @SomeException

tryHoist ::
  Member (Embed IO) r =>
  (Text -> e) ->
  IO a ->
  Sem r (Either e a)
tryHoist f =
  fmap (mapLeft f) . tryAny

tryThrow ::
  Members [Embed IO, Error e] r =>
  (Text -> e) ->
  IO a ->
  Sem r a
tryThrow f =
  fromEither <=< tryHoist f

traverseLeft ::
  Applicative m =>
  (a -> m b) ->
  Either a b ->
  m b
traverseLeft f =
  either f pure
{-# INLINE traverseLeft #-}

defaultJson :: TH.Name -> TH.Q [TH.Dec]
defaultJson =
  deriveJSON defaultOptions
