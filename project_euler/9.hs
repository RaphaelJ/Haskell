main =
    let triplets = [ (a, b, c) | a <- [1..1000 `div` 3]
                               , b <- [a+1..(1000-a) `div` 2]
                               , c <- [1000 - a - b]
                               , a^2+b^2 == c^2 ]
    in print $ head $ triplets