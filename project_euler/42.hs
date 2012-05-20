import Data.List
import Data.Maybe

import Utils (triangle)

letters = zip ['A'..'Z'] [1..] 

isTriangleWord w = 
    let letterOrd l = fromJust $ lookup l letters
        val = sum $ map letterOrd w
    in val `elem` takeWhile (<= val) triangle

main = do
    c <- readFile "42_words.txt"
    let ws = read c :: [String]
    print $ length $ filter isTriangleWord ws