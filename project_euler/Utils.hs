module Utils (
    -- ^ Numbers' properties
      divides, isPrime, factorial, isAbundant, nDigits, logInt, isPandigital
    -- ^ Sequences
    , fibonacci, factors, prime, triangle, hailstone, digits, number, rotations
    -- ^ Others
    , palindrome, nthTriangle, toBinary
) where

import Data.List

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

-- | Returns the list of all factors of n (doesn't returns the reciprocal
-- factor).
factors n =
    let square = floor $ sqrt $ fromIntegral n
    in [ x | x <- [1..square], x `divides` n ]
    
-- | Returns the list of all factors of n with theirs reciprocal (n inclusive).
factors' n =
    let fs = factors n
    in nub $ fs ++ reverse (map (n `quot`) fs)

-- | Returns an infinite list of prime numbers.
prime = filter isPrime [2..]

-- | Returns True is the number is abundant (the sum of its divisors exceeds 
-- the number).
isAbundant n = n < (sum $ init $ factors' n)

-- | Returns an infinite list of triangle numbers.
triangle = go 1 0
  where
    go n acc =
        let acc' = acc + n
        in acc' : go (n + 1) acc'

-- | Return the hailstone sequence from n to 1.
hailstone 1             = [1]
hailstone n | even n    = n : hailstone (n `quot` 2)
            | otherwise = n : hailstone (3 * n + 1)

-- | Returns the number of digits of a number.
nDigits 0 = 1
nDigits n = logInt 10 n + 1
    
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
        
-- | Returns the nth triangle number
nthTriangle n = (n * (n + 1)) `div` 2

-- | Converts the number to binary
toBinary 0 = 0
toBinary n = 
    go (logInt 2 n) n
  where
    go i 0 = 0
    go i n' = if n' >= 2^i
                 then 10^i + go (i - 1) (n' - 2^i)
                 else go (i - 1) n'