module Polysemy.Http.Manager where

import Network.HTTP.Client (newManager)
import qualified Network.HTTP.Client as HTTP (Manager)
import Network.HTTP.Client.TLS (mkManagerSettings)

import Polysemy.Http.Data.Manager (Manager(..))

interpretManagerWith ::
  HTTP.Manager ->
  InterpreterFor Manager r
interpretManagerWith manager = do
  interpret \ Get -> pure manager
{-# INLINE interpretManagerWith #-}

-- |Trivial interpreter with a globally shared 'Manager' instance.
interpretManager ::
  Member (Embed IO) r =>
  InterpreterFor Manager r
interpretManager sem = do
  manager <- embed (newManager settings)
  interpretManagerWith manager sem
  where
    settings =
      mkManagerSettings def Nothing
{-# INLINE interpretManager #-}
