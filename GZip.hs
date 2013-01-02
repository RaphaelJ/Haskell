import Control.Applicative
import qualified Data.ByteString.Lazy as B
import Codec.Compression.GZip

import Data.Conduit
import Data.Conduit.Binary
import Data.Conduit.Zlib (gzip, ungzip)

import System.Environment
import System.IO

main = do
    [opt, inPath] <- getArgs
    case opt of
         "-d" -> decompress <$> B.readFile inPath >>= B.hPut stdout
         "-c" -> compress <$> B.readFile inPath >>= B.hPut stdout
         "-d2" ->
            runResourceT $! sourceFile inPath $= ungzip $$ sinkHandle stdout
         "-c2" ->
            runResourceT $! sourceFile inPath $= gzip $$ sinkHandle stdout