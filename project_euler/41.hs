import Data.List

import Utils (isPrime, number)

main = print $ head [ x 
    | n <- [9,8..1]
    , x <- reverse $ sort $ map number $ permutations [1..n]
    , isPrime x
    ]