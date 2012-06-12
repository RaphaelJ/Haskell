import Data.List
import Data.Maybe

import Utils (isTriangle, isPentagonal, hexagonals)

main = 
    print $ fromJust $ find condition $ dropWhile (<= 40755) hexagonals
  where
    condition x = isPentagonal x && isTriangle x