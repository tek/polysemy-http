module Polysemy.Http.Manager where

import Network.Connection (settingDisableCertificateValidation)
import Network.HTTP.Client (newManager)
import qualified Network.HTTP.Client as HTTP (Manager)
import Network.HTTP.Client.TLS (mkManagerSettings)

import Polysemy.Http.Data.Manager (Manager(..))

interpretManagerWith ::
  Member (Embed IO) r =>
  HTTP.Manager ->
  InterpreterFor Manager r
interpretManagerWith manager = do
  interpret $ \case
    Get -> pure manager

interpretManager ::
  Member (Embed IO) r =>
  InterpreterFor Manager r
interpretManager sem = do
  manager <- embed (newManager settings)
  interpretManagerWith manager sem
  where
    settings =
      mkManagerSettings def { settingDisableCertificateValidation = True } Nothing
