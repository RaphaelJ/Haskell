import Data.Ratio

fractions = [ frac |
      n <- [11..98], d <- [n+1..99]
    , let (a, b) = n `quotRem` 10
    , let (a', b') = d `quotRem` 10
    , let frac = n % d
    , b /= 0 && b' /= 0
    , isCurious (a, b) (a', b') frac
    ]

isCurious (a, b) (a', b') frac
    | a == a'   = b % b' == frac
    | a == b'   = b % a' == frac
    | b == a'   = a % b' == frac
    | b == b'   = a % a' == frac
    | otherwise = False

main = print $ product fractions