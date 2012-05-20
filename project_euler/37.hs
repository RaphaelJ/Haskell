import Data.List

import Utils (prime, isPrime, digits, number)

continuousPrime n = 
    let digs = digits n
        l = length digs
        leftToRight = map (number . flip drop digs) [1..l - 1]
        rightToLeft = map (number . flip take digs) [l -1, l - 2..1]
    in all isPrime (n : (leftToRight ++ rightToLeft))

main = print $ sum $ take 11 $ filter continuousPrime $ dropWhile (< 10) prime 