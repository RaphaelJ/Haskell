import Data.Array

import Utils (isAbundant)

main = print $ solve 

solve :: Int
solve =
    let abundant = map fst $ filter snd $ assocs abundantArr
        abundantArr = listArray (1,28123) $ map isAbundant [1..28123]
        isAbundantSum n = not $ null $ [ () |
              x <- takeWhile (< n) abundant
            , abundantArr ! (n - x)
            ]
    in sum $ filter (not . isAbundantSum) [1..28123]