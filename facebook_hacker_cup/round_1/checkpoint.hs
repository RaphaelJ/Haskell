import Control.Monad
import Control.Monad.ST
import Data.Array (Array, assocs)
import Data.Array.ST (STArray, runSTArray)
import qualified Data.Array.MArray as A
import Data.Ix (range)
import Data.List
import Data.Maybe
import qualified Data.Map as M
import Debug.Trace

maxValue = 10000000
maxSquare = ceiling $ sqrt $ maxValue

main = interact (showCases . map resolve . readCases)

showCase :: (Integer, Integer) -> String
showCase (i, v) = "Case #" ++ show i ++ ": " ++ show v
showCases = unlines . map showCase . zip [1..]

readCases = map read . tail . lines

resolve :: Integer -> Integer
resolve = minimum . map pathDistance . divisors

divisors :: Integer -> [(Integer, Integer)]
divisors n =
    let square = floor $ sqrt $ fromIntegral n
        divisors' = filter (\x -> n `rem` x == 0) [1..square]
    in map (\x -> (x, n `quot` x)) divisors'

pathDistance :: (Integer, Integer) -> Integer
pathDistance (s1, s2) = minDistMapLookup s1 + minDistMapLookup s2

minDistMapLookup :: Integer -> Integer
minDistMapLookup n =
    case M.lookup n minDistMap of
         Just x  -> {-trace (show x)-} x
         Nothing -> {-trace (show n ++ " not found")-} n

minDistMap :: M.Map Integer Integer
minDistMap =
    M.fromListWith min dsts
  where
    values = assocs $ pascal $ maxSquare 
    coordsToDst ((x, y), v) = (v, max 1 (x+y))
    dsts = map coordsToDst values

pascal :: Integer -> Array (Integer, Integer) Integer
pascal size =
    runSTArray pascal'
  where
    pascal' :: ST s (STArray s (Integer, Integer) Integer)
    pascal' = do
        arr <- A.newArray ((0, 0), (size-1, size-1)) 1
        forM_ (range ((1,1),(size-1, size-1))) $ \i@(x, y) -> do
            up <- A.readArray arr (x, y-1)
            left <- A.readArray arr (x-1, y)
            A.writeArray arr i (up + left)
        return arr