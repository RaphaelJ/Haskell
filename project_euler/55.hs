import Utils (palindrome, digits, number)

isLychrel = isLychrel' 0
  where
    isLychrel' 50 _ = True
    isLychrel' i  n =
        let n' = number $ reverse $ digits n
            s = n + n'
        in if palindrome s
              then False
              else isLychrel' (i + 1) s

main =
    print $ length $ filter isLychrel $ [10..10000]