import Control.Monad.State
import Data.List
import Data.Function
import qualified Data.Map as M

import Utils (hailstone)

type LengthCache = M.Map Integer Integer

hailstoneLength :: Integer -> State LengthCache Integer
hailstoneLength 1 = return 1
hailstoneLength n = do
    cache <- get
    case M.lookup n cache of
        Just l  -> return l
        Nothing -> do
            let n' = if even n then n `div` 2
                               else 3 * n + 1
            l <- (+1) `fmap` hailstoneLength n'
            put $ M.insert n l cache
            return l

-- 5sec (uses a Map as a dynamic cache table inside the State monad)
main =
    let valueWithLength v = do -- Creates a tuple with the value and its length
            l <- hailstoneLength v
            return (v, l)
        lengths = evalState (mapM valueWithLength [1..1000000]) M.empty
    in print $ fst $ maximumBy (compare `on` snd) lengths

-- 23sec
-- main =
--     let chains = map hailstone [1..1000000]
--     in print $ head $ maximumBy (compare `on` length) chains