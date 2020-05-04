module Network.HTTP.Polysemy.Data.StreamEvent where

import Network.HTTP.Polysemy.Data.Response (Response)
import Network.HTTP.Polysemy.Data.StreamChunk (StreamChunk)

data StreamEvent r c h a where
  Acquire :: Response c -> StreamEvent r c h h
  Chunk :: h -> StreamChunk -> StreamEvent r c h ()
  Result :: Response c -> h -> StreamEvent r c h r
  Release :: h -> StreamEvent r c h ()
