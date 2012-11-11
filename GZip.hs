import Control.Applicative
import qualified Data.ByteString.Lazy as B
import Codec.Compression.GZip

import System.Environment
import System.IO

main = do
    [opt, inPath] <- getArgs
    case opt of
         "-d" -> decompress <$> B.readFile inPath >>= B.hPut stdout
         "-c" -> compress <$> B.readFile inPath >>= B.hPut stdout