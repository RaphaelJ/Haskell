import Data.List
import Data.Maybe

main = interact (unlines . map showCase . zip [1..] . tail . lines)
  where
    showCase (i, t) = "Case #" ++ show i ++ ": " ++ solve t

solve = unwords . map show . solve' . tail . map read . words
  where
--     solve' xs =
--         let s = sum xs
--             n = fromIntegral $ length xs
--             minScore = (2.0 * s) / n
--             solution x = (minScore - x) / s * 100.0
--         in map solution xs
--     solve' xs =
--         let s = sum xs
--             n = fromIntegral $ length xs
--             minScore = (2.0 * s) / n
--             solution v = find (\x -> v + x * s >= maxScoreRest x v) choix 
--             choix = [0,0.00000001..1]
--             maxScoreRest x v = ((s - v) + (1 - x) * s) / (n - 1)
--         in map (\v -> fromJust (solution v) * 100) xs
    solve' xs =
        let s = sum xs
            n = fromIntegral $ length xs
            minScore = (2.0 * s) / n
            solution v = solveEq (\x -> (v + x * s) - (maxScoreRest x v)) 0 1.0 0.00000000001
            maxScoreRest x v = ((s - v) + (1 - x) * s) / (n - 1)
        in map (\v -> solution v * 100) xs
        
solveEq f a b prec 
    | b - a <= prec = (a + b) / 2 
    | otherwise     = 
        let x = (a + b) / 2
        in if f x > 0 
              then solveEq f a x prec
              else solveEq f x b prec