import Text.ParserCombinators.Parsec

parseIni = parse ini ""

ini = do sections <- many section
         eof
         return sections
           
section = do t <- title
             v <- many vars
             return (t, v)

title = do char '['
           nom <- many anyChar
           string "]\n"
           return nom

variable = do n <- name
              char '='
              v <- value
              char '\n'
              return (n, v)

name = do 
              