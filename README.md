# group-purchase

Alice, Bertrand, Clara and Desmond often make group purchases. They keep the list of their purchases in a csv file like this one:

```
item              ,unit price,quantity,buyer
pencils           ,  0.50    ,  20    ,Bertrand
paper             ,  1.78    ,  25    ,Alice
paper             ,  1.78    ,  50    ,Desmond
laundry detergent ,  2.00    ,  10    ,Clara
trash bags        ,  4.38    ,  100   ,Clara
gift cards        ,  7.99    ,  1     ,Bertrand
lightbulbs        ,  1.00    ,  10    ,Clara
~ shipping        , 40.00    ,  1     ,~ shipping
```

the last line of the file is special, as it contains the shipping fee for the purchase.

The shipping fee is not split into equal parts: rather it is attributed to each member in proportion to their total purchase amount.

- Alice : 1.78 * 25 = 44.50
- Bertrand : 0.50 * 20 + 7.99 = 17.99
- Clara : 2.00 * 10 + 4.38 * 100 + 1.10 * 10 = 469.00
- Despond : 1.78 * 50 = 89.50

the total without shipping is 620.99

- Alice's part of the shipping fee = 44.50 / 620.99 * 40.00 = 2.866391
- Bertrand's part = 17.99 / 620.99 * 40.00 = 1.158795
- Clara's part = 469.00 / 620.99 * 40.00 = 30.209826
- Desmond's part = 89.50 / 620.99 * 40.00 = 5.764988 


The result is thus
Alice : 44.50 + 2.86 = 47.36
Bertrand : 17.99 + 1.15 = 19.14
Clara :  469.00 + 30.21 = 499.23
Desmond : 89.5 + 5.76 = 95.26

As each part is being rounded to the cent, missing cents have to be added to the biggest part.

for a total payment of 660.99

620.99

