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
```
group-purchase-exe <data/input.csv
Right (["item","unitp","qty","amount","buyer"],[Order {item = "pencils", unitPrice = 0.5, quantity = 20, buyer = "Bertrand"},Order {item = "paper", unitPrice = 1.5, quantity = 25, buyer = "Alice"},Order {item = "paper", unitPrice = 1.8, quantity = 50, buyer = "Desmond"},Order {item = "laundry detergent", unitPrice = 2.0, quantity = 10, buyer = "Clara"},Order {item = "trash bags", unitPrice = 4.3, quantity = 100, buyer = "Clara"},Order {item = "gift cards", unitPrice = 8.0, quantity = 1, buyer = "Bertrand"},Order {item = "lightbulbs", unitPrice = 1.0, quantity = 10, buyer = "Clara"}])
```

## Printing csv content (amounts)

