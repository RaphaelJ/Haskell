import Data.List
import Data.Maybe

import Debug.Trace

import Utils (pentagonals, isPentagonal)

minimalPentagonal =
    go (head pentagonals) [] (tail pentagonals) Nothing
  where
    go p prec next (Just m) = 
        let cur = find (diffSumPentagonal p) $ takeWhile (> p - m) prec
            m' = case cur of
                      Just c  -> Just (min (p - c) m)
                      Nothing -> Just m
            continue = p - (head prec) < m
        in if continue
              then go (head next) (p : prec) (tail  next) m'
              else m
        
    go p prec next Nothing =
        let cur = find (diffSumPentagonal p) prec
        in go (head next) (p : prec) (tail next) ((p -) `fmap` cur)

    diffSumPentagonal a b = isPentagonal (a - b) && isPentagonal (a + b)
    
main = print minimalPentagonal