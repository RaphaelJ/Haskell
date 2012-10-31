import Data.List
import Data.Maybe

import Utils (divides, primes, composites, sqrtInt)

main =
    print $ fromJust $ find condition composites
  where
    condition x = 
        let primes' = takeWhile (< x) primes
            validSum p = 
                (2 `divides` (x - p)) && (isJust $ sqrtInt $ (x - p) `quot` 2 )
        in odd x && (not $ any validSum primes')