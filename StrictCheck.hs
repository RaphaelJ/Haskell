{-# OPTIONS -fglasgow-exts #-}
-- Module      :  StrictCheck
-- Copyright   :  (c) Olaf Chitil, University of Kent, 2006
-- License     :  BSD
--
-- Maintainer  :  Olaf Chitil
-- Stability   :  highly experimental
-- Portability :  non-portable (GHC-specific)
-- Version     :  0.01

-- StrictCheck tests whether a given function is least-strict.
-- If it is not, StrictCheck proposes changes to make the function less strict.
-- It requires the ChasingBottoms library of Nils Danielsson:
-- http://www.cs.chalmers.se/~nad/software/ChasingBottoms/docs/
--
-- This is a very early version used for my presentation at
-- IFL 2006 in Budapest, see slides and paper for rudementary documentation.


module StrictCheck(test1,test2,test3,testData,partShow,module Data.Generics) where 

import Data.Generics
import Test.ChasingBottoms.IsBottom
import Test.ChasingBottoms.ApproxShow
import Test.ChasingBottoms.SemanticOrd
import Monad(msum,when)
import Debug.Trace


-- top-level test drivers for interaction with the user

-- test 1-argument function
test1 ::  (Data a, Data b) => Int -> (a -> b) -> IO ()
test1 d f = test (results f (testData d))

-- test 2-argument function
test2 ::  (Data a, Data b, Data c) => Int -> (a -> b -> c) -> IO ()
test2 d f = test (results (uncurry f) (tail (testData d))) -- drop tuple _|_

-- test 3-argument function
test3 ::  (Data a, Data b, Data c, Data d) => Int -> (a -> b -> c -> d) -> IO ()
test3 d f = test (results (\(x1,x2,x3) -> f x1 x2 x3) (tail (testData d)))


-- Check whether given function is least strict for given test data.
-- Inefficient, because function is applied to all test data until
-- counter example is found, does not use fact that function is continuous.
results :: (Data a, Data b) => (a -> b) -> [[a]] -> [Result]
results f td= map single td 
  where
  single (t:ts) = Result {arguments = partShow t
                         ,output = partShow partOut
                         ,proposed = partShow totalMeet
                         ,same = partOut ==! totalMeet}
    where
    partOut = f t
    totalMeet = foldr1 (/\!) (map f ts)

data Result = Result {arguments :: String
                     ,output :: String
                     ,proposed :: String
                     ,same :: Bool}


test :: [Result] -> IO ()
test = go True 0
  where
  go l n [] = do 
    putStrLn ("Completed " ++ show n ++ " test(s).")
    when l $ putStrLn "Function seems to be least strict."
  go l n (r:rs) = 
    if same r then
      go l (n+1) rs
     else do
      putStrLn "Function seems not to be least strict."
      putStrLn ("Input(s): " ++ arguments r)
      putStrLn ("Current output: " ++ output r)
      putStrLn ("Proposed output: " ++ proposed r)
      whenUserWishes "  Continue" $ go False (n+1) rs

whenUserWishes :: String -> IO () -> IO ()
whenUserWishes wish action = do
  putStr (wish++"? ")
  reply <- getLine
  when (null reply || reply=="y") action


-- show partial value but do not cut off at any depth
partShow :: Data a => a -> String
partShow = approxShow 100000



-- Generation of test data

-- type for storing test data
-- first a list of total values,
-- then a list of partial values, each element followed by a list of total
-- completions of the partial value
data TT a = TT [a] [[a]] deriving (Data,Typeable,Show)

fromConstrTT :: Data a => (forall a . Data a => TT a) -> Constr -> TT a
fromConstrTT g = gunfold k z
  where
  k :: Data b => TT (b -> r) -> TT r
  k (TT fs fss) = 
    TT [f b | f <- fs, b <- bs] 
       ([map f bs | f <- fs, bs <- bss] ++ [map ($ b) fs | fs <- fss, b <- bs])
    where
    TT bs bss = g 
  z x = TT [x] []

concatTT :: [TT a] -> TT a
concatTT = foldr plusTT (TT [] [])

plusTT :: TT a -> TT a -> TT a
plusTT (TT ts tss) (TT ms mss) = TT (ts++ms) (tss++mss)


testData :: Data a => Int -> [[a]]
testData d = map (take 20) ts  -- cut down total completions; ARBITRARY number
                  -- 10 too small for disin of Clausify
  where
  TT _ ts = genUpTo d

-- Taken from Ralf Laemmel, SYB website, and adapted
-- Generate all terms of a given depth
genUpTo :: Data a => Int -> TT a
genUpTo 0 = TT [] []
genUpTo d = result
   where
     -- Getting hold of the result (type)

     result = addBottom (concatTT (map recurse cons))

     addBottom (TT ts tss) = 
       if d > 2  -- ensure that there are total completions
                 -- comparing length ts far more tricky, type dependent
         then TT ts ((bottom:ts):tss) 
         else TT ts tss

     -- Find all terms headed by a specific Constr
     recurse :: Data a => Constr -> TT a
     recurse = fromConstrTT (genUpTo (d-1))

     cons :: [Constr]
     cons = case dataTypeRep ty of
              AlgRep cons -> cons
              IntRep      -> [mkIntConstr ty 0,mkIntConstr ty 1]
              FloatRep    -> [mkFloatConstr ty 0,mkFloatConstr ty 1]
              StringRep   -> [mkStringConstr ty "a",mkStringConstr ty "b"] -- also for Char
              NoRep       -> error "type value not representable"
      where
        ty = dataTypeOf ((\(TT (x:_) _) -> x) result)     

