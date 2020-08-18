module Polysemy.Http.Data.StreamEvent where

import Polysemy.Http.Data.Response (Response)
import Polysemy.Http.Data.StreamChunk (StreamChunk)

data StreamEvent r c h a where
  Acquire :: Response c -> StreamEvent r c h h
  Chunk :: h -> StreamChunk -> StreamEvent r c h ()
  Result :: Response c -> h -> StreamEvent r c h r
  Release :: h -> StreamEvent r c h ()
