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
Right (["item","unitp","qty","amount","buyer"],
    [Order {item = Item {label = "pencils"} , unitPrice = 0.5, quantity = 20, buyer = "Bertrand"}
    ,Order {item = Item {label = "paper"}, unitPrice = 1.5, quantity = 25, buyer = "Alice"}
    ,Order {item = Item {label = "paper"}, unitPrice = 1.8, quantity = 50, buyer = "Desmond"}
    ,Order {item = Item {label = "laundry detergent"}, unitPrice = 2.0, quantity = 10, buyer = "Clara"}
    ,Order {item = Item {label = "trash bags"}, unitPrice = 4.3, quantity = 100, buyer = "Clara"}
    ,Order {item = Item {label = "gift cards"}, unitPrice = 8.0, quantity = 1, buyer = "Bertrand"}
    ,Order {item = Item {label = "lightbulbs"}, unitPrice = 1.0, quantity = 10, buyer = "Clara"}])
```

  - Order
    - can be read from a csv ByteString
    - can't be created from a csv record with an item starting with ~
    - can't be created from a csv record with an empty item
    - can be created from a csv file where ~ records are filtered out

## Printing csv content (amounts)

```
group-purchase-exe <data/input.csv
buyer,amount
Bertrand,10.00
Alice,37.50
Desmond,90.00
Clara,20.00
Clara,430.00
Bertrand,8.00
Clara,10.00
```

## Group amount per buyer

```
group-purchase-exe <data/input.csv
buyer,amount
Alice,37.50
Bertrand,18.00
Clara,460.00
Desmond,90.00
```
