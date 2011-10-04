import Control.Monad.State
import Text.ParserCombinators.Parsec

-- IN PROGRESS
-- Implementing a (very) simple compiler from a (very) simple functionnal
-- (interger only typed) language to (stack heavy) x86 ASM.
-- Using Parsec for parsing and a monad to generate x86 assembly.

data SExpr = Literal String | SExpr [SExpr] deriving (Show, Read)
    
data Statement = Let String Int Statement
               | Call String | If Statement Statement Statement
               | Add Statement Statement | Sub Statement Statement
               | Variable Int -- Index in the stack
               | Number Int deriving (Show, Read)

-- compiler = generator . tokenizer . parser
-- interpretter = executor . tokenizer . parser

-- | Parse s-expressions string as an s-expressions list
parser :: Parser SExpr
parser = do sexprs <- many (spaces >> sexpr)
            eof
            return $ SExpr sexprs
            
literal = do Literal `fmap` many1 alphaNum
sexpr = do char '(' 
           nested <- many (try $ spaces >> (sexpr <|> literal))
           spaces >> char ')'
           return $ SExpr nested

type Instructions = [String] -- x86 instructions
type StackIdentifiers = [String] -- Variables's names on the stack
type Functions = [(String, (Int, Instructions)] -- Declared functions with # of arguments & instructions
    
generator :: State (SExpr, StackIdentifiers, Functions) Instructions
generator = do
    
    
tokenizer (SExpr ["let", name, args, def]) =
    let stack' = reverse args ++ stack -- Append arguments on the stack
    in 
    
executor = undefined
generator = undefined

-- (let pi () 3)
-- (let pow (a b) (
--     (let mult (m n) (
--         if m
--             (add m (mult m (sub n 1)))
--             0
--         )
--     )
--     if b
--        (mult a (pow a (sub b 1)))
--        1
--     )
-- )