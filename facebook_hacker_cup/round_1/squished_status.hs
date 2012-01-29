import Control.Monad.State
import Data.List
import qualified Data.Map as M
import Data.Maybe
import Debug.Trace

type Cache = M.Map String Integer

main = interact (showCases . map resolve . readCases)

showCase (i, v) = "Case #" ++ show i ++ ": " ++ show v
showCases = unlines . map showCase . zip [1..]

readCases = groupByPair . tail . words

groupByPair (x:y:xs) = (read x, y) : groupByPair xs
groupByPair _        = []

resolve (maxChar, msg) =
    evalState (resolve' maxChar msg) M.empty `rem` 0xfaceb00c

resolve' :: Integer -> String -> State Cache Integer
resolve' maxChar []      = return 1
resolve' maxChar msg     = do
    cache <- get
    case M.lookup msg cache of
         Just x  -> return x
         Nothing -> do
            n1 <- takeNum 1
            case n1 of
                 Just r1 -> do
                    n2 <- takeNum 2
                    case n2 of
                         Just r2 -> do
                            n3 <- takeNum 3
                            case n3 of
                                 Just r3 -> return $ r1 + r2 + r3
                                 Nothing -> return $ r1 + r2
                         Nothing -> return r1
                 Nothing -> return 0
  where
    takeNum l =
        let s = take l msg
            n = read s
            msg' = drop l msg
        in if length s == l && n > 0 && n <= maxChar
              then do
                  nested <- resolve' maxChar msg'
                  cache <- get
                  put $ M.insert msg' nested cache
                  return $ Just $ nested 
              else return $ Nothing