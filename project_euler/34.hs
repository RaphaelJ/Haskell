import Utils (factorial, digits)

main = print $ sum [ x | x <- [10..10^7]
    , x == sum (map factorial $ digits x)
    ]