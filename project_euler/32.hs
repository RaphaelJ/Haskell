import Data.List

import Utils (digits, number)

pandigitals = nub [ multiplicand * multiplier
    | xs <- permutations [1..9]
    , a <- [1..3]
    , let (sMultiplicand, remainder) = splitAt a xs
    , let multiplicand = number sMultiplicand
    , b <- [1..5-a]
    , let (sMultiplier, remainder') = splitAt b remainder
    , let multiplier = number sMultiplier
    , (sort $ digits $ multiplicand * multiplier) == sort remainder'
    ]

main = print $ sum $ pandigitals