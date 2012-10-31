import Data.Array

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

-- | Returns an array catalans numbers.
catalansArr l = arr
  where
    arr = listArray (0, l) $ map catalan' [0..l]
    catalan' 0 = 1
    catalan' n =
        sum [ (arr ! i) * (arr ! ((n - 1) - i)) | i <- [0..n-1] ]

main = interact (unlines . map (show . (catalans !!) . read) . lines)