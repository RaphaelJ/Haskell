import qualified Data.Set as S

import Utils (primes, digits)

setPrimes :: S.Set Integer
setPrimes = S.fromAscList $ takeWhile (< 10) primes

isPrime :: Integer -> Bool
isPrime n = n `S.member` setPrimes

nSubsets :: Integer -> [Integer] -> Integer -> Integer
nSubsets n []     _      = n
nSubsets n (p:ps) curSum =
    let curSum' = curSum + p
        n' = nSubsets (if isPrime curSum' then n + 1 else n) ps curSum'
    in nSubsets n' ps curSum

main =
    print $ nSubsets 0 (S.toList setPrimes) 0