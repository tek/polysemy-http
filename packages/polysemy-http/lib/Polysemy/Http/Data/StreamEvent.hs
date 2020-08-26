module Polysemy.Http.Data.StreamEvent where

import Polysemy.Http.Data.Response (Response)
import Polysemy.Http.Data.StreamChunk (StreamChunk)

-- |Control algebra for streaming requests.
-- @r@ is the final return type of the stream handler, after the request is processed to completion.
-- @c@ is the raw chunk data type
-- @h@ is the handle type that identifies the active request. It is entirely controlled by the consumer and may be
-- empty.
data StreamEvent r c h a where
  -- |Used when calling the handler after the request has been initiated, but no data has been read.
  Acquire :: Response c -> StreamEvent r c h h
  -- |Used when calling the handler for each received chunk.
  Chunk :: h -> StreamChunk -> StreamEvent r c h ()
  -- |Used when calling the handler after the request has finished transferring. It should return the final result.
  Result :: Response c -> h -> StreamEvent r c h r
  -- |Used to finalize the transfer, e.g. for resource cleanup.
  Release :: h -> StreamEvent r c h ()
