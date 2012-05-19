coins = reverse [1, 2, 5, 10, 20, 50, 100, 200]

ways n = 
    ways' n coins
  where
    ways' 0 coins = 1
    ways' n' coins' = 
        let available = dropWhile (> n') coins'
        in sum $ [ 
              ways' (n' - c) coins'' | c <- available
            , let coins'' = dropWhile (> c) coins'
            ]

main = print $ ways 200