{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
-- Command line utility which is able to find match between an image and a
-- database of indexed images.

import Control.DeepSeq
import qualified Control.Exception as E
import Control.Monad
import Data.Array.IArray
import Data.Function
import Data.Int
import Data.List
import Data.Maybe
import System.Directory (doesFileExist)
import System.Environment (getArgs)
import System.IO (IOMode (..), openFile, hPrint, hClose)
import Text.Printf

import qualified Vision.Image as I
import qualified Vision.Histogram as H
import Debug.Trace

maxChiDist :: Float
maxChiDist = 10


type Tag = String
data IndexedHist = IndexedHist !Tag !(H.Histogram Float)

instance Show IndexedHist where
    show (IndexedHist tag hist) = printf "%s %s" tag (show $ elems hist)

instance NFData IndexedHist

main = do
    args <- getArgs
    case args of
        [dbPath] -> do
            match dbPath
        _ -> do
            putStrLn "Usage :"
            putStrLn "ImageMatch <DB path>"
            putStrLn ""
            putStrLn "Commands (on stdin):"
            putStrLn "Look for a match in the DB :"
            putStrLn "\t? <filepath>"
            putStrLn "\tPrints the tag of the best match with the Chi-Square"
            putStrLn "\tscore or \"F\" (for Fail) if no good match."
            putStrLn "Look for a match in the DB and add the image to the DB if"
            putStrLn "there is no perfect match :"
            putStrLn "\t+ <tag> <filepath>"

loadDatabase path = do
    exists <- doesFileExist path
    if exists then readFile path >>= return . map readEntry . lines
              else return []
  where
    readEntry str =
        let (tag, histStr) = break (== ' ') str
        in IndexedHist tag (listArray (0, 255) $ read histStr)

match dbPath = do
    !db <- force `fmap` loadDatabase dbPath
    h <- openFile dbPath AppendMode
    c <- getContents
    go (lines c) db h
    hClose h
  where
    go []     _  _ = return ()
    go (l:ls) db h = do
        let (w:ws) = words l

        res <- E.try $ case w of
            "?"  -> do
                let path = unwords ws

                !hist <- calcHist path
                return (findMatch hist db, db)
            "+" -> do
                let tag = head ws
                    path = unwords $ tail ws
                !hist <- calcHist path

                let e = IndexedHist tag hist
                    match = findMatch hist db

                -- Adds to the DB if not a match
                when (isNothing match) $
                    hPrint h e

                return (match, e : db)

        case res of
            Right (Nothing, db') -> do
                putStrLn "F"
                go ls db' h
            Right (Just (IndexedHist tag _, score), db') -> do
                printf "M %s\n" tag
                go ls db' h
            Left (e :: E.SomeException) -> do
                printf "E %s\n" (show e)
                go ls db h

    calcHist path = do 
        i <- I.load path 
        return $ H.equalizeHist (H.calcHist i :: H.Histogram Int32)

    findMatch hist [] = Nothing
    findMatch hist db =
        let scores = [ (e, histDist hist e) | e <- db ]
            best@(_, score) = minimumBy (compare `on` snd) scores
        in if score < maxChiDist then Just best
                                 else Nothing

    histDist hist (IndexedHist _ hist') = 
        H.compareChi hist hist'
