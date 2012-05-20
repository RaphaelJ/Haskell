import Data.List

import Utils (digits)

decimals = 0 : concatMap digits [1..]

main = print $ product $ map (decimals !!) [
      1, 10, 100, 1000, 10000, 100000, 1000000
    ]