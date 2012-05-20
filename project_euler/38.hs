import Data.List

import Utils (isPandigital)

concatened :: Int -> [Int]
concatened n =
    map read $ scanl step (show n) [2..]
  where
    step acc i = acc ++ show (n * i)
    
main = print $ maximum $ concat [ cs' | x <- [5000..9999]
    , let cs = dropWhile (< 10^8) $ takeWhile (< 10^9) $ concatened x
    , let cs' = filter isPandigital cs
    ]