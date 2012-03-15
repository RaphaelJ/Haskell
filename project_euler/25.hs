import Data.List

import Utils (fibonacci)

main =
    let Just i = findIndex (\n -> length (show n) >= 1000) fibonacci
    in print (i + 1)