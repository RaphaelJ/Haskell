import System.Random
import Data.List(sort, foldl1')
import Data.Maybe
import Control.Parallel (par, pseq)

takeMins nbre xs = takeMins' nbre xs Nothing
    where takeMins' 0 xs mini    = [ fromJust mini ]
          takeMins' nbre xs mini = case mini of
			Just mini' -> takeMins' (nbre-1) xs $ Just (foldl1' (\x acc ->                                                           if x <= mini' then acc else (min x acc)) xs)
			Nothing    -> takeMins' (nbre-1) xs $ Just (foldl1' min xs)

main = do
	gen <- newStdGen
	let nbre = take 1000000 $ randoms gen :: [Int]
--	print nbre
	let ret = take 10000 $ sort nbre
	let ret = takeMins 10000 $ take 1000000 $ randoms gen :: [Int]
	print ret
