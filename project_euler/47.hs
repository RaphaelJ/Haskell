import Data.List
import Data.Maybe

import Utils (primes, p)

primeFactors n acc 0 (p:ps) = Nothing
primeFactors n acc i []     = Nothing
primeFactors n acc i (p:ps) 
    | acc == n      = Just [acc]
    | p `divides` n = 
        
    | otherwise     = primeFactors n acc i ps 
        
   
main = 
    primeFactors n [] 4
    print $ fromJust $ find condition composites
  where
    condition x = 
        let primes' = takeWhile (< x) primes
            validSum p = 
                (2 `divides` (x - p)) && (isJust $ sqrtInt $ (x - p) `quot` 2 )
        in odd x && (not $ any validSum primes')
        