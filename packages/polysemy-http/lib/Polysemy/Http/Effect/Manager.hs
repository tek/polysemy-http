{-# options_haddock prune #-}
-- |Description: Manager Effect, Internal
module Polysemy.Http.Effect.Manager where

import qualified Network.HTTP.Client as HTTP (Manager)

-- |This effect abstracts the creation of a 'Manager' in order to allow pool sharing in a flexible way.
data Manager :: Effect where
  Get :: Manager m HTTP.Manager

makeSem ''Manager
