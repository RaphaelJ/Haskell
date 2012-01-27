import Data.List
import Data.Map
import Data.Maybe
import Data.Ord
import Debug.Trace

newtype Product = Product { price :: Integer, weight :: Integer }

Product p w `prefered` Product p' w' = 
    (p < p' && w <= w') || (w < w' && p <= p')
        

main = interact (showCases . map resolve . readCases)

showCase (i, v) = "Case #" ++ show i ++ ": " ++ show v
showCases = unlines . map showCase . zip [1..]

readCases = map (concat . words) . tail . lines

initialMap = M.fromList $ zip "HACKERCUP" [0,0..]

resolve cs =
    M.foldl' min 0 $ go initialMap cs
  where 
    go m []      = m
    go m (c:cs') = 
        let m' = M.insertWith' (+) c 1 m
        in go m' cs