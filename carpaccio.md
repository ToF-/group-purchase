# Carpaccio
## Reading some text content, printing it back
```
>group-purchase-exe <src/GroupPurchase.hs
module GroupPurchase
    where

process :: IO ()
process = do
    contents <- getContents
    putStr contents
```

## Reading some csv content (orders), printing the values
## Printing csv content (amounts)

