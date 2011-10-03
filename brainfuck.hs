-- This is a small Brainfuck interpreter.
-- It uses the State monad for parsing and execution.
-- The execution isn't done inside the execution function but inside
-- interact.

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
    if xs == []
    then return []
    else do
        let (x:xs') = xs
        put xs'
        case x of
            '[' -> do
                nested <- parse
                fmap (ExprHook nested :) parse
            ']' ->
                put xs' >> return []
            '>' -> fmap (ExprGT:) parse
            '<' -> fmap (ExprLT:) parse
            '+' -> fmap (ExprPlus:) parse
            '-' -> fmap (ExprMinus:) parse
            '.' -> fmap (ExprDot:) parse
            ',' -> fmap (ExprComma:) parse
            _ -> parse

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
