import Data.Function
import Data.List

main = print $ maximumBy (compare `on` nTriangles) [1..1001]
    
nTriangles p = length [ (a, b, c) | a <- [1..p - 2], b <- [a..p - 1 - a]
    , let c = p - a - b
    , c^2 == a^2 + b^2
    ]