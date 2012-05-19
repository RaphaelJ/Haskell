import Data.Function
import Data.List
import qualified Data.Map as M

nRemainders b = 
    nRemainders' 1 M.empty 1
  where
    nRemainders' a' acc i =
        case a' `rem` b of
             0 -> 0 
             r -> case M.lookup r acc of
                       Just ix -> i - ix
                       Nothing -> nRemainders' (r*10) (M.insert r i acc) (i+1)

main =
    let remainders = [ (x, nRemainders x) | x <- [1..1000] ]
    in print $ fst $ maximumBy (compare `on` snd) remainders