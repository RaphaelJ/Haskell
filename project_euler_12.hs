import Data.List
import Data.Maybe

factors :: Int -> Int
factors n = 2 * (length $ filter isFactor [1..square])
  where
    square = floor $ sqrt $ fromIntegral n
    isFactor i = n `mod` i == 0

triangles = go 1 0
  where
    go n acc =
        let acc' = acc + n
        in acc' : go (n + 1) acc'

main = print $ fromJust $ find gt1000 triangles
  where
    gt1000 = (> 1000) . factors