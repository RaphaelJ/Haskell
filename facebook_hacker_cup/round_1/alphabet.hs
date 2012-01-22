import Data.List
import qualified Data.Map as M
import Data.Maybe
import Debug.Trace

main = interact (showCases . map resolve . readCases)

showCase (i, v) = "Case #" ++ show i ++ ": " ++ show v
showCases = unlines . map showCase . zip [1..]

readCases = map (concat . words) . tail . lines

initialMap = M.fromList $ zip "HACKERCUP" [0,0..]

resolve cs =
    foldl1 min $ M.elems $ go initialMap cs
  where 
    go m []      = m
    go m (c:cs') = 
        let m' = M.adjust (+ 1) c m
        in go m' cs'