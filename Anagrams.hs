import Data.Char (toLower)
import Data.List 
import qualified Data.Map as M
import Data.Maybe
import System.Environment

main = do
    [dico] <- getArgs
    content <- readFile dico
    putStr $ unlines $ map show $ anagrams $ lines content
    
anagrams ws =
    [ fromJust $ M.lookup w counts | w <- sorted ]
 where
    sorted = map (sort . lowerCase) ws
    counts = foldl' accumulator M.empty sorted
    accumulator acc w =
        M.insertWith (+) w 1 acc 
    lowerCase (x:xs) = toLower x : xs
    