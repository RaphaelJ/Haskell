import Data.List
import Data.Maybe

import Utils(factors, triangle)

main = print $ fromJust $ find gt500 triangle
  where
    gt500 = (> 500) . (* 2) . length . factors