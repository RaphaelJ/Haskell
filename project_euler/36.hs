import Utils (palindrome, toBinary)

palindronic n = palindrome n && palindrome (toBinary n)

-- Only odd numbers can be a binary palindrome
main = print $ sum $ filter palindronic [1,3..10^6 - 1]