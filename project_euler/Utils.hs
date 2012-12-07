module Utils (
    -- ^ Numbers' properties
      divides, isPrime, factorial, isAbundant, nDigits, sqrtInt, logInt
    , isPandigital, triangle, isTriangle, pentagonal, isPentagonal, hexagonal
    , isHexagonal
    -- ^ Sequences
    , fibonacci, factors, primes, composites, triangles, pentagonals
    , hexagonals, hailstone, digits, number, rotations
    -- ^ Others
    , palindrome, toBinary, binarySearch
) where

import Data.List
import Data.Maybe

-- | Returns True if a divides b.
a `divides` b = b `rem` a == 0

-- | Returns True is the number is prime.
isPrime n = n > 1 && (null $ tail {- tail remove 1 -} $ factors $ n)

-- | Returns the factorial of n
factorial n = product [1..n]

-- | Returns an infinite list of fibonacci numbers.
fibonacci = 1 : fibonacci' 0 1
  where
    fibonacci' a b = let x = a + b
                     in x : fibonacci' b x

-- | Returns the list of all factors of i (doesn't returns the reciprocal
-- factor).
factors i =
    let square = floor $ sqrt $ fromIntegral i
    in [ x | x <- [1..square], x `divides` i ]
    
-- | Returns the list of all factors of n with theirs reciprocal (n inclusive).
factors' n =
    let fs = factors n
    in nub $ fs ++ reverse (map (n `quot`) fs)

-- | Returns an infinite list of prime numbers.
primes =
    go 2 0
  where
    go i n =
        let square = floor $ sqrt $ fromIntegral i
            primeFactors = takeWhile (<= square) $ take n primes
        in if any (`divides` i) primeFactors
              then go (i + 1) n
              else i : go (i + 1) (n + 1)

-- | Returns an infinite list of composite (== non-prime) numbers.
composites = filter (not . isPrime) [2..]

-- | Returns True is the number is abundant (the sum of its divisors exceeds 
-- the number).
isAbundant n = n < (sum $ init $ factors' n)

-- | Returns the nth triangle number.
triangle n = (n * (n + 1)) `div` 2

-- | Returns an infinite list of triangle numbers.
triangles = map triangle [1..]

-- | Returns True if x is a triangular number using a binary search for an
-- integer solution.
isTriangle x = x > 0 && isJust (binarySearch triangle 0 x x)

-- | Returns the nth pentagonal number.
pentagonal n = (n * (3 * n - 1)) `div` 2
        
-- | Returns an infinite list of pentagonal numbers.
pentagonals = map pentagonal [1..]

-- | Returns True if x is a pentagonal number using a binary search for an
-- integer solution.
isPentagonal x = x > 0 && isJust (binarySearch pentagonal 0 x x)
    
-- | Returns the nth hexagonal number.
hexagonal n = n * (2 * n - 1)

-- | Returns an infinite list of hexagonal numbers.
hexagonals = map hexagonal [1..]

-- | Returns True if x is a hexagonal number using a binary search for an
-- integer solution.
isHexagonal x = x > 0 && isJust (binarySearch hexagonal 0 x x)
    
-- | Return the hailstone sequence from n to 1.
hailstone 1             = [1]
hailstone n | even n    = n : hailstone (n `quot` 2)
            | otherwise = n : hailstone (3 * n + 1)

-- | Returns the number of digits of a number.
nDigits 0 = 1
nDigits n = logInt 10 n + 1

-- | Returns Just x if x is an integer square root of n.
sqrtInt n = binarySearch (^2) 0 n n 
    
-- | Returns the integer logarithm of the number (i.e. logInt 2 1100 = 10).
logInt base n =
    go 0
  where 
    go i | base^i > n = i - 1
         | otherwise  = go (i+1)

-- | An n-digit number is pandigital if it makes use of all the digits 1 to n
-- exactly once.
isPandigital d = 
    let digs = digits d
    in sort (digs) == [1..length digs]

-- | Gives the list of digits from a number.
digits n =
    reverse $ digits' n
  where
    digits' 0 = []
    digits' n' = 
        let (q, r) = n' `quotRem` 10
        in r : digits' q

-- | Gives the number from a list of digits.
number =
    fst . foldr step (0, 0)
  where
    step x (acc, i) = (acc + x * 10^i, i+1)

-- | Returns all the rotations of the digits of a number.
rotations n = 
    map rotate [0..nDig - 1]
  where
    nDig = nDigits n
    rotate i = 
        let (q, r) = n `quotRem` (10^i)
        in q + r * (10^(nDig - i))

-- | Returns True if s is a palindrome.
palindrome s =
    let s' = show s
    in s' == reverse s'

-- | Converts the number to binary
toBinary 0 = 0
toBinary n = 
    go (logInt 2 n) n
  where
    go i 0 = 0
    go i n' = if n' >= 2^i
                 then 10^i + go (i - 1) (n' - 2^i)
                 else go (i - 1) n'

-- | Returns the integer x between ]a; b] which which satisfies f(x) = n.
-- Returns Nothing if doesn't exists.
binarySearch f a b n = 
    go 0 n
  where
    go mi ma 
        | ma - mi > 1 =  
            let m = (mi + ma) `div` 2
            in case n `compare` f m of
                    LT -> go mi (m - 1)
                    GT -> go m ma
                    EQ -> Just m
        | f ma == n   = Just ma
        | otherwise   = Nothing