import Utils(palindrome)

main =
    let nbres = [ x*y | x <- [100..999], y <- [100..999] ]
    in print $ maximum $ filter palindrome nbres