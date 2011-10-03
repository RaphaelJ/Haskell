import Text.ParserCombinators.Parsec

-- Implementing a (very) simple compiler from a (very) simple functionnal
-- (interger typed) language to x86 ASM
-- Using Parsec.
-- In progress.

data SExpr = Literal String | SExpr [SExpr] deriving (Show, Read)
    
data Statement = Let String Int Statement
               | Call String | If Statement Statement Statement
               | Add Statement Statement | Sub Statement Statement
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

tokenizer stack (SExpr ["let", name, args, def]) =
    let stack' = reverse args ++ stack
    
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