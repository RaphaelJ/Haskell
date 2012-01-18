import Utils(divises)

main =
    let divise20 n = all (`divises` n) [1..20]
    in print $ head $ filter divise20 [1..]