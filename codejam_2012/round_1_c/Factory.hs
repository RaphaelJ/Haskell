import Data.List
import qualified Data.Map as M
import Data.Maybe

main = interact (unlines . map showCase . zip [1..] . group3 . tail . lines)
  where
    showCase (i, t) = "Case #" ++ show i ++ ": " ++ solve t
    group3 [] = []
    group3 (a:b:c:xs) = [a,b,c] : group3 xs
    

solve = show . snd . solve' M.empty . map (groupPair . map read . words) . tail
  where
    groupPair [] = [] 
    groupPair (x:y:xs) = (x, y) : groupPair xs 
    solve' :: M.Map [[(Integer, Integer)]] Integer -> [[(Integer, Integer)]] -> (M.Map [[(Integer, Integer)]] Integer, Integer)
    solve' acc [[], _] = (acc, 0)
    solve' acc [_, []] = (acc, 0)
    solve' acc arg@[((nb, tb) : bs), ((nt, tt) : ts)] = 
        case arg `M.lookup` acc of
             Just a  -> (acc, a)
             Nothing ->
                if tb == tt 
                    then if nb == nt
                         then addToAcc acc arg [bs, ts] nt
                         else if nb > nt
                                 then addToAcc acc arg [((nb - nt, tb) : bs), ts] nt
                                 else addToAcc acc arg [bs, ((nt - nb, tt) : ts)] nb
                    else
                         let (acc' , n1) = addToAcc acc arg [bs, ((nt, tt) : ts)] 0
                             (acc'', n2) = addToAcc acc' arg [((nb, tb) : bs), ts] 0
                         in (acc'', max n1 n2)
    addToAcc acc arg arg' n =
        let (acc', inner) = solve' acc arg'
            solution = n + inner
        in (M.insert arg solution acc', solution)
    