import Utils (digits)

isSumOfDigits n = n == sum [ x^5 | x <- digits n ]

main = print $ sum $ filter isSumOfDigits [10..10^6]