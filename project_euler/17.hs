import Data.List (find)
import Data.Maybe (fromJust)

import Utils (divides)

numbers = reverse [ 
      (1, "one"), (2, "two"), (3, "three"), (4, "four"), (5, "five")
    , (6, "six"), (7, "seven"), (8, "eight"), (9, "nine"), (10, "ten")
    , (11, "eleven"), (12, "twelve"), (13, "thirteen"), (14, "fourteen")
    , (15, "fifteen"), (16, "sixteen"), (17, "seventeen"), (18, "eighteen")
    , (19, "nineteen")
    , (20, "twenty"), (30, "thirty"), (40, "forty"), (50, "fifty")
    , (60, "sixty"), (70, "seventy"), (80, "eighty"), (90, "ninety")
    , (100, "onehundred"), (200, "twohundred"), (300, "threehundred")
    , (400, "fourhundred"), (500, "fivehundred"), (600, "sixhundred")
    , (700, "sevenhundred"), (800, "eighthundred"), (900, "ninehundred")
    , (1000, "onethousand") ]

-- | Gives a list of words from an integer.
number2words n =
    go n
  where
    -- Take the word with the nearest lower value until zero
    go 0 = wAnd
    go n' = let (number, word) = fromJust $ find ((<= n') . fst) numbers
            in word : go (n' - number)
    -- Add "and" between hundred/thousand if something is following 
    wAnd | n >= 100 && not (100 `divides` n) = ["and"]
         | otherwise                         = []
   

words2length = sum . map length

main = print $ sum $ map (words2length . number2words) [1..1000]