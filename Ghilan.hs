import Data.Int
import Test.QuickCheck

bruteForce n = 
    go 1 n 
  where
    go a b
        | b - a <  0 = 0
        | b - a <= 1 = 1
        | otherwise  = let m = (a + b + 1) `div` 2
                       in go a (m - 1) + go (m + 1) b

formule 0 = 0
formule 1 = 1
formule n = 
    let (d, r) = (n - 1) `divMod` 2
    in formule d + formule (d + r)

propEquals :: Int16 -> Bool
propEquals n = bruteForce (abs n) == formule (abs n)

main = quickCheck propEquals