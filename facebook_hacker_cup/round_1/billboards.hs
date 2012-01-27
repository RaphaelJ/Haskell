import Data.List
import Data.Maybe
import Debug.Trace

main = interact (showCases . map resolve . readCases)

showCase (i, v) = "Case #" ++ show i ++ ": " ++ show v
showCases = unlines . map showCase . zip [1..]

readCase (w:h:str) = (read w, read h, map length str)
readCases = map (readCase . words) . tail . lines

resolve (width, height, ws) =
    fromMaybe 0 $ find (go ws width height) [1000,999..1]
  where 
    go []      _      _       _    = True
    go (w:ws') width' height' size
        | height' < size    =
            False -- No more space
        | width' < w * size = -- New line
            go (w:ws') width (height' - size) size 
        | otherwise         = -- Ok, next word
            go ws' (width' - (w + 1) * size) height' size