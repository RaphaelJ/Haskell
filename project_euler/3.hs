import Data.List

import Utils (factors, isPrime)

main =
    let n = 600851475143
    in print $ maximum $ filter isPrime $ factors n