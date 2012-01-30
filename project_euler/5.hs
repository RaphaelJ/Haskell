import Utils (divides)

main =
    let divides20 n = all (`divides` n) [1..20]
    in print $ head $ filter divides20 [1..]