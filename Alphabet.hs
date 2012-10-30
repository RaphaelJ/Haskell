import Control.Monad.State
import Data.Char (toLower, isAlpha)
import Data.Function (on)
import Data.List (sortBy)
import Data.Set (Set, (\\), size, empty, intersection, fromAscList, fromList)
import qualified Data.Set as S
import System.Environment (getArgs)

import Debug.Trace

alphabet = fromAscList ['a'..'z']

initPangram = (
      words "superacknowledgment blepharoconjunctivitis oxyquinaseptol sulfamethylthiazole"
--       ["The", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"]
    , length (fst initPangram)
    )   

main = do
    dict <- getArgs >>= readFile . head
    print $ minimumSet (prepareWords dict) ([], 0, alphabet) (Just initPangram)
  where 
    -- For each words of the dictionary file, add the letters to a set. 
    -- Then sort the words by the number of different letters (the set's size), 
    -- descending.
    prepareWords :: String -> [(String, Set Char)]
    prepareWords dict =
        let ws = words dict
            sets = [ (w, fromList $ map toLower $ filter isAlpha w) | w <- ws ]
        in sortBySetSize sets
        
    sortBySetSize :: [(String, Set Char)] -> [(String, Set Char)]
    sortBySetSize = reverse . sortBy (compare `on` (size . snd))
    
    minimumSet :: [(String, Set Char)] -> ([String], Int, Set Char) 
               -> Maybe ([String], Int) -> Maybe ([String], Int)
    minimumSet [] cur best = best
    minimumSet ((w, wSet):ws) cur@(curPhrase, curLen, curRemain) best
        | Just (bestPhrase, bestLen) <- best
        , curLen + 1 >= bestLen  = best
        | S.null curRemain = traceShow (Just (curPhrase, curLen)) $ Just (curPhrase, curLen)
        | otherwise     = 
            let withWord = minimumSet ws' (w:curPhrase, curLen + 1, remain) best 
                remain = curRemain \\ wSet
                ws' = sortBySetSize [ (iw, iSet') | (iw, iSet) <- ws
                    , let iSet' = iSet \\ wSet, size iSet' > 0
                    ]
            in minimumSet ws cur withWord