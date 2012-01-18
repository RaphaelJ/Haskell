import Utils(divises)

main = print $ sum $ [ x | x <- [1..999], mult3or5 x ]
  where
    mult3or5 x = 5 `divises`s x || 3 `divises` x