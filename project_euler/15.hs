import Data.List
import Data.Maybe

size = 20

routes rs pos@(x, y) 
    | x == 0 || y == 0 = (pos, 1) : rs -- Only one road on the border
    | otherwise        =
        -- Sums the right and top points routes if not on the border
        let v = fromJust (lookup (x-1, y) rs) + fromJust (lookup (x, y-1) rs)
        in (pos, v) : rs

main =
    let points = [ (x, y) | x <- [0..size], y <- [0..size] ]
    in print $ snd $ head $ foldl' routes [] points