module GroupPurchase
    where

process :: IO ()
process = do
    contents <- getContents
    putStr contents
