import Data.Char
import Control.Monad.State
import System

data Expr = ExprGT | ExprLT
          | ExprPlus | ExprMinus
          | ExprDot | ExprComma
          | ExprHook [Expr]
    deriving (Show)

main = do
    [script] <- getArgs
    code <- readFile script
    interact (execute $ evalState parse code)

parse :: State String [Expr]
parse = do
    xs <- get
    case xs of
        ('[':xs') -> do
            put xs'
            nested <- parse
            next <- parse 
            return $ ExprHook nested : next
        (']':xs') ->
            put xs' >> return []
        ('>':xs') -> addAndParse ExprGT xs'
        ('<':xs') -> addAndParse ExprLT xs'
        ('+':xs') -> addAndParse ExprPlus xs'
        ('-':xs') -> addAndParse ExprMinus xs'
        ('.':xs') -> addAndParse ExprDot xs'
        (',':xs') -> addAndParse ExprComma xs'
        [] -> return []
        (_:xs') -> put xs' >> parse
  where
    -- Add the current expression and parse what is following
    addAndParse expr xs = do
        put xs
        next <- parse
        return $ expr : next

type Tape = ([Int], [Int])

-- Return a function to use with interact
execute es = evalState execute' (es, ([0,0..], []))
  where
    execute' :: State ([Expr], Tape) (String -> String)
    execute' = do
        (es, tape) <- get
        case es of
            (ExprHook inner : es') ->
                if (head $ fst $ tape) == 0
                then put (es', tape) >> execute' -- Next
                else put (inner, tape) >> execute' >> -- Execute nested
                     modify (\(_, tape') -> (es, tape')) >> execute' -- Recurse with new tape
            (ExprGT : es') ->
                let (x:xs, ys) = tape in put (es', (xs, x:ys)) >> execute'
            (ExprLT : es') ->
                let (xs, y:ys) = tape in put (es', (y:xs, ys)) >> execute'
            (ExprPlus : es') ->
                let (x:xs, ys) = tape in put (es', (x+1:xs, ys)) >> execute'
            (ExprMinus : es') ->
                let (x:xs, ys) = tape in put (es', (x-1:xs, ys)) >> execute'
            (ExprDot : es') -> do
                let (x:_, _) = tape
                put (es', tape)
                str <- execute'
                return $ \cx -> (chr x : str cx)
            (ExprComma : es') ->
                -- Return a new function which remove a char, put it on
                -- the tape and execute the following expressions.
                let (_:xs, ys) = tape
                in return $ \(c:cx) ->
                       evalState execute' (es', (ord c : xs, ys)) cx
                    
            [] -> return (\_ -> "")