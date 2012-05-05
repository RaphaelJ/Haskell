import Data.List
import Data.Maybe

main = interact (unlines . map showCase . zip [1..] . tail . lines)
  where
    showCase (i, t) = "Case #" ++ show i ++ ": \n" ++ solve t

solve = printableSolve . tail . map read . words
  where
    printableSolve xs = 
        case solve' xs of
             Just (a, b) = unlines $ map (unwords . map show) [a, b]
             Nothing     = "Impossible"
    solve' xs =
        let s = sum xs

subsets []     = []
subsets (x:xs) accA accB = 
    concat [
        subsets 
        ]