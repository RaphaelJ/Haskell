import Data.List
import Data.Function

import Utils (prime)

quadratic a b n = n^2 + a * n + b

consecPrimes a b = 
    let inPrime a = a `elem` (takeWhile (<= a) prime)
    in length $ takeWhile inPrime [ quadratic a b x | x <- [0..] ]

main =
    let quadratics = [ (a*b, consecPrimes a b) | 
                a <- [-999..999], b <- [-999..999] 
            ]
    in print $ fst $ maximumBy (compare `on` snd) quadratics