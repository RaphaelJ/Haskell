import Data.List

import Utils (divides, number)

interesting [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10] =
    2 `divides` number [d2, d3, d4]
    && 3 `divides` number [d3, d4, d5]
    && 5 `divides` number [d4, d5, d6]
    && 7 `divides` number [d5, d6, d7]
    && 11 `divides` number [d6, d7, d8]
    && 13 `divides` number [d7, d8, d9]
    && 17 `divides` number [d8, d9, d10]

main = print $ sum $ map number $ filter interesting $ permutations [0..9]

-- main = print $ [ number dgs
--     | let d6 = 5
--     , d1 <- [1..9] \\ [d6]
--     , d2 <- [1..9] \\ [d1, d6]
--     , d3 <- [1..9] \\ [d1, d2, d6]
--     , d4 <- [2, 4, 6, 8] \\ [d1, d2, d3, d6]
--     , d5 <- [2, 4, 6, 8] \\ [d1, d2, d3, d4, d6]
--     , d7 <- [0, 2, 7] \\ [d1, d2, d3, d4, d5, d6]
--     , d8 <- [2, 8] \\ [d1, d2, d3, d4, d5, d6, d7]
--     , d9 <- [6, 8] \\ [d1, d2, d3, d4, d5, d6, d7, d8]
--     , d10 <- [7, 9] \\ [d1, d2, d3, d4, d5, d6, d7, d8, d9]
--     , let dgs = [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
--     ]