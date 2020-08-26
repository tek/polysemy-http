module Polysemy.Http.Data.Log where

import Polysemy.Internal (send)

-- |An effect that wraps 'Colog.Polysemy.Log' for less boilerplate
-- Constructors are manual because 'HasCallStack' is always in scope
data Log :: Effect where
  Debug :: HasCallStack => Text -> Log m ()
  Info :: HasCallStack => Text -> Log m ()
  Warn :: HasCallStack => Text -> Log m ()
  Error :: HasCallStack => Text -> Log m ()
  ErrorPlus :: (HasCallStack, Traversable t) => Text -> t Text -> Log m ()

debug ::
  HasCallStack =>
  Member Log r =>
  Text ->
  Sem r ()
debug =
  send . Debug

info ::
  HasCallStack =>
  Member Log r =>
  Text ->
  Sem r ()
info =
  send . Info

warn ::
  HasCallStack =>
  Member Log r =>
  Text ->
  Sem r ()
warn =
  send . Warn

error ::
  HasCallStack =>
  Member Log r =>
  Text ->
  Sem r ()
error =
  send . Error

errorPlus ::
  HasCallStack =>
  Traversable t =>
  Member Log r =>
  Text ->
  t Text ->
  Sem r ()
errorPlus =
  send .: ErrorPlus
