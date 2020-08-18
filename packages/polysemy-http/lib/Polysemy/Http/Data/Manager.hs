module Polysemy.Http.Data.Manager where

import qualified Network.HTTP.Client as HTTP (Manager)

data Manager m a where
  Get :: Manager m HTTP.Manager

makeSem ''Manager
