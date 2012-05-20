import Data.Array.Unboxed

import Utils (isPrime, prime, rotations)

cacheIsPrime :: Array Int Bool
cacheIsPrime = listArray (1, 10^6 - 1) $ False : map isPrime [2..10^6 - 1]

circularPrime = all (cacheIsPrime !) . rotations

main = print $ length $ filter circularPrime [1..10^6 - 1]
