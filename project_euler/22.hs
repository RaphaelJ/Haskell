import Data.List
import Data.Maybe

main = do
    content <- readFile "22_names.txt"
    print $ solve (words content)
    
alphabet = zip ['A'..'Z'] [1..]

solve names =
    let names' = zip [1..] (sort names) 
    in sum $ map (\(i, n) ->
        sum (map (\l -> fromJust $ lookup l alphabet) n) * i
    ) names'