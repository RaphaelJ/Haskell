import qualified Data.Map as M

import Utils (factors)

main =
    let factorsSum n = 1 + (sum $ map (\d -> d + n `quot` d) $ tail $ factors n) 
        sums = map (\n -> (n, factorsSum n)) [1..10000]
        sumsMap = M.fromList sums
        hasAmicable (n, s) =
            case M.lookup s sumsMap of
                 Just s' -> s' == n && n /= s
                 Nothing -> False
        amicables = filter hasAmicable sums
    in print $ sum $ map fst $ amicables