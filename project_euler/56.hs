import Utils (digits)

main = print $ maximum [ sum $ digits $ a ^ b | a <- [1..99], b <- [1..99] ]