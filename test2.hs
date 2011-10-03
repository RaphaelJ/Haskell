import System.Random
import Data.List

main = do
    let l = (take 10000000 $ randoms (mkStdGen 1)) :: [Int]
    print $ last $ take 100000 $ sort l