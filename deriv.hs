import Data.Char

data Sexpr = Sexpr [Sexpr]
           | Literal String
            deriving (Show)

data Operator = Addition [Operator]
               | Multiplication [Operator]
               | Subtraction [Operator]
               | Division [Operator]
               | Exponential Operator Operator
               | Logarithm Operator
               | Sinus Operator
               | Cosinus Operator
               | Tangent Operator
               | Number Double
               | Variable String
                deriving (Show)

{- Sépare les différents éléments d'une SExpression.
   (Sexpr, Suite de la chaine) -}
analyseSexpr :: String -> Sexpr
analyseSexpr' :: String -> ([Sexpr], String)

-- Nested
analyseSexpr' ('(':xs)  = (Sexpr nested : follow, xsFollow)
    where (nested, xsNested) = analyseSexpr' xs
          (follow, xsFollow) = analyseSexpr' xsNested

analyseSexpr' (')':xs)  = ([], xs)
analyseSexpr' (' ':xs)  = analyseSexpr' xs

-- Literal
analyseSexpr' (x:xs)    = (Literal (x : literal) : follow, xsFollow)
    where (literal, xsLiteral)   = analyseLiteral xs
          (follow, xsFollow)     = analyseSexpr' xsLiteral

analyseSexpr' []        = ([], [])

analyseSexpr xs = head $ fst $ analyseSexpr' xs

{- Extrait la chaine de caractère jusqu'au premier espace.
   (Literal, Suite de la chaine) --}
analyseLiteral :: String -> (String, String)

-- Fin de l'operateur
analyseLiteral []       = ([], [])
analyseLiteral (' ':xs) = ([], xs)
analyseLiteral ('(':xs) = ([], '(':xs)
analyseLiteral (')':xs) = ([], ')':xs)

analyseLiteral (x:xs)   = (x : next, xsNext)
    where (next, xsNext) = analyseLiteral xs

{- Convertit une SExpression en arbre d'opérateurs. -}
tokenize :: Sexpr -> Operator

-- Extrait les expressions composées (opérateurs)
tokenize (Sexpr (x:xs)) = case x of 
        (Literal "+")    -> Addition $ map tokenize xs
        (Literal "*")    -> Multiplication $ map tokenize xs
        (Literal "-")    -> Subtraction $ map tokenize xs
        (Literal "/")    -> Division $ map tokenize xs
        (Literal "expt") -> Exponential (tokenize $ xs!!0) (tokenize $ xs!!1)
        (Literal "log")  -> Logarithm $ tokenize $ head xs
        (Literal "sin")  -> Sinus $ tokenize $ head xs
        (Literal "cos")  -> Cosinus $ tokenize $ head xs
        (Literal "tan")  -> Tangent $ tokenize $ head xs

-- Extrait les variables et les nombres
tokenize (Literal l) | isDouble l = Number $ read l
                     | otherwise  = Variable l
    where isDouble s = all (\c -> c == '.' || isDigit c) s

{- Dérive le second argument sur la variable contenue dans le premier. -}
derivative :: String -> Operator -> Operator

derivative var (Number n) = Number 0
derivative var (Variable n) | n == var  = Number 1
                            | otherwise = Number 0

derivative var (Exponential a b) = case (a, b) of
        (Variable x, _) | x == var -> Multiplication [b', Exponential a' (Subtraction [b', Number 1])]
        (_, Variable x) | x == var -> Multiplication [Exponential a' b', Logarithm a']

--derivative var (Multiplication []) = 
--        (Number n) | n == 
--derivative var (Multiplication x:xs) = case x of
--        (Number n) | n == 