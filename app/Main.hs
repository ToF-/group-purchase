module Main where

import GroupPurchase
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    groupPurchase (args!!0) (args!!1)
