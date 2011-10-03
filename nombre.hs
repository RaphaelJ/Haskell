import qualified Data.Text as T

main = putStrLn $ T.unlines $ T.chunksOf 69 $ T.pack $ show $ 500^500^2
