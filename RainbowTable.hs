import Codec.Compression.Zlib.Raw (compress, decompress)
import Control.Parallel.Strategies
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Hash.MD5 (Str (..), md5i)
import Data.List
import qualified Data.Map as M
import Data.Maybe (catMaybes)
import Data.String.Utils (strip)
import System (getArgs)

-- Generate and use a rainbow table to crack md5 hashes.
-- The reduce function is not really efficient.

data RainbowTable = RainbowTable {
      rtLines :: M.Map Integer String
    , rtCharset :: String
    , rtPassLen :: Integer
    , rtChainLen :: Int
    } deriving (Show, Read)

-- Charsets
alpha = [' '] ++ ['a'..'z'] ++ ['A'..'Z']
numeric = [' '] ++ ['0'..'9']
alphanum = [' '] ++ ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']

-- Hashing functions
md5 :: String -> Integer
md5 = md5i . Str

main = do
    args <- getArgs
    menu args

menu ["train", "numeric"] = save "numeric" $ compute md5 numeric 7 1500 30000
menu ["train", "alphnum"] = save "alphnum" $ compute md5 alphanum 4 3000 50000
menu ["load", "numeric"] = load "numeric" >>= decryptInterface
menu ["load", "alphnum"] = load "alphanum" >>= decryptInterface
menu _ = putStrLn $ "train numeric (7 chars) | train alphanum (4 chars) " ++
                    "| load numeric | load alphanum"

decryptInterface table = do
    putStrLn "Hash in decimal or hexadecimal (start with 0x). Enter to decrypt"
    matches <- fmap (show . decrypt md5 table . read) getLine
    putStrLn $ "Solutions: " ++ matches
    decryptInterface table

-- | Compute a 'RainbowTable'.
-- > compute md5 alphanum 8 4200 20000000
compute hashFct charset passLen chainLen nLines =
    RainbowTable linesMap charset passLen chainLen
  where
    linesMap = M.fromList $ parMap strategy chain [1..nLines]
    chain chainNum =
        let first = reduceFct chainNum
            lastHash = snd $ hashChain hashFct reduceFct first !! chainLen
        in (lastHash, first)
    reduceFct = reduce charset (fromIntegral $ length charset) passLen
    strategy = evalTuple2 rseq rseq

-- | Decrypt a password using a 'RainbowTable'
decrypt hashFct (RainbowTable linesMap charset passLen chainLen) hash =
    nub $ map fst matches
  where
    chain = take chainLen . hashChain hashFct reduceFct
    following = map snd $ chain $ reduceFct hash
    hashs = hash : following
    
    matchesStart = catMaybes $ map (`M.lookup` linesMap) hashs
    matches = filter ((== hash) . snd) $ concatMap chain matchesStart
    
    reduceFct = reduce charset (fromIntegral $ length charset) passLen

-- | Save the 'RainbowTable' using Zlib.
save :: String -> RainbowTable -> IO ()
save path = B.writeFile path . compress . B.pack . show

-- | Load the 'RainbowTable' using Zlib.
load :: String -> IO RainbowTable
load path = fmap (read . B.unpack . decompress) $ B.readFile path

-- | Generate a password with the hash's value (cf. change base)
reduce :: String -> Integer -> Integer -> Integer -> String
reduce charset charsetlen passLen hash =
    strip $ reduce' (hash `mod` (charsetlen^passLen)) (passLen-1)
  where
    reduce' reminder i
        | i >= 0 =
            let divisor = charsetlen^i
                c = charset !! fromInteger (reminder `div` divisor)
                reminder' = reminder `mod` divisor
            in c : reduce' reminder' (i-1)
        | otherwise = []

-- | Generate an infinite chain of password and corresponding hash starting
-- with a first password.
hashChain hashFct reduceFct startPass =
    go startPass
  where
    go pass =
        let !hash = hashFct pass
            pass' = reduceFct hash
        in (pass, hash) : go pass'