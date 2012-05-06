import Data.Array
import qualified Data.Map as M
import Data.List
import Data.Maybe

main = interact (showCase 1 . tail . lines)
  where
    showCase i [] = ""
    showCase i ls = 
        let (n, a, ls') = parse ls
        in "Case #" ++ show i ++ ": " ++ solve n a ++ "\n" ++ showCase (i + 1) ls'
   
parse :: [String] -> (Int, Array Int [Int], [String])
parse (l:ls) = 
    let nClasses = read l
        (classes, ls') = splitAt nClasses ls
        classes' = zip [1..] $ map (map read . tail . words) classes
        a = array (1, nClasses) classes'
    in (nClasses, a, ls')

solve n a = 
    if any isDiamond [1..n]
       then "Yes"
       else "No"
  where
    isDiamond classe =
        snd $ isDiamond' M.empty (a ! classe)
        
    isDiamond' acc [] = (acc, False)
    isDiamond' acc (i:is) = 
        let acc' = M.insert i () acc
        in if i `M.member` acc
              then (acc, True)
              else let (acc'', isDia) = isDiamond' acc' (a ! i)
                   in if isDia 
                         then (acc'', isDia)
                         else isDiamond' acc'' is