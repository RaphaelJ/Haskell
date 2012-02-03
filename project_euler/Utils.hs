module Utils (
    -- ^ Numbers' properties
      divides, isPrime, factorial
    -- ^ Sequences
    , fibonacci, factors, prime, triangle, hailstone, digits
    -- ^ Others
    , palindrome
) where

-- | Returns True if a divides b.
a `divides` b = b `rem` a == 0

-- | Returns True is the number is prime.
isPrime = null . tail {- remove 1 -} . factors

-- | Returns the factorial of n
factorial n = product [1..n]
    
-- | Returns an infinite list of fibonacci numbers.
fibonacci = fibonacci' 0 1
  where
    fibonacci' a b = let x = a + b
                     in x : fibonacci' b x

-- | Returns the list of all factors of n (doesn't returns the reciprocal
-- factor).
factors n =
    let square = floor $ sqrt $ fromIntegral n
    in [ x | x <- [1..square], x `divides` n ]

-- | Returns an infinite list of prime numbers.
prime = filter isPrime [2..]

-- | Returns an infinite list of triangle numbers.
triangle = go 1 0
  where
    go n acc =
        let acc' = acc + n
        in acc' : go (n + 1) acc'

-- | Return the hailstone sequence from n to 1
hailstone 1             = [1]
hailstone n | even n    = n : hailstone (n `div` 2)
            | otherwise = n : hailstone (3 * n + 1)

-- | Gives the list of digits from a number
digits 0 = []
digits n = 
    let (q, r) = n `quotRem` 10
    in r : digits q

-- | Returns True if s is a palindrome.
palindrome s =
    let s' = show s
    in s' == reverse s'