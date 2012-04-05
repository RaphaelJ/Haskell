-- | Computes the n th number of Catalan using a naive recursion.
catalan 0 = 1
catalan n = sum [ catalan i * catalan ((n - 1) - i) | i <- [0..n-1] ]

-- | Returns the list of all catalans numbers.
catalans = map catalan' [0..]
  where
    catalan' 0 = 1
    catalan' n =
        let precs = take n catalans
        in sum $ zipWith (*) precs (reverse precs)

main = interact (unlines . map (show . (catalans !!) . read) . lines)