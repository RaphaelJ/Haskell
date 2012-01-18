import Utils(fibonacci)

main = print $ sum $ filter even $ takeWhile (< 4000000) fibonacci