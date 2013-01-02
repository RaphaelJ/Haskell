import Data.List
import Data.Maybe

import Utils (digits)

main =
    print $ fromJust $ find cond [10..]
  where
    cond i =
        let first = sort $ digits i
        in all (== first) [ sort $ digits $ j * i | j <- [2..6] ]