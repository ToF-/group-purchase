# group-purchase
## The problem to be solved

Alice, Bertrand, Clara and Desmond often make group purchases. They keep the list of their purchases in a csv file like this one:

```
item              ,unit price,quantity,buyer
pencils           ,  0.50    ,  20    ,Bertrand
paper             ,  1.50    ,  25    ,Alice
paper             ,  1.80    ,  50    ,Desmond
laundry detergent ,  2.00    ,  10    ,Clara
trash bags        ,  4.30    ,  100   ,Clara
gift cards        ,  8.00    ,  1     ,Bertrand
lightbulbs        ,  1.00    ,  10    ,Clara
~ shipping        , 40.00    ,  1     ,~ shipping
```

the last line of the file is special, as it contains the shipping fee for the purchase.

The shipping fee is not split into equal parts: rather it is attributed to each member in proportion to their total purchase amount.

- Alice : 37.50
- Bertrand : 18.00
- Clara : 460.00
- Despond : 90.0

the total without shipping is 605.50

```
Alice    : 40.00 * 37.50 / 605.50 =  2.477291
Bertrand : 40.00 * 18    / 605.50 =  1.1891
Clara    : 40.00 * 460   / 605.50 = 30.388109
Desmond  : 40.00 * 90    / 605.50 =  5.9455

total                              40.00
```

The result is thus a csv file like this one:
```
buyer    ,  part
Alice    ,   39.98
Bertrand ,   19.19
Clara    ,  490.38
Desmond  ,   95.95
~ total  ,  645.50
```

Cascade rounding is being applied:

```
      n        rt          rrt         p       rtp

   39.977291   39.977291   39.98      39.98    39.98
   19.1891     59.166391   59.17      19.19    59.17
  490.388109  549.5545    549.55     490.38   549.55
   95.9455    645.5       645.50      95.95   645.50
```
where 
- _rt_ = running total of _n_
- _rrt_ = rounded running total
- _p(i) = _rrt_ - _rtp(i-1)_
- _rtp_ = running total of _p_

## Types
### Price

```Haskell
> p = price 42.795   -- the value will be rounded to the cent
> p
42.80
> -- internal representation is an Integer
> value p
4280
> fromPrice p        -- it can be extracted as a Double
42.8
> p `times` 4        -- it can be multiplied by an Integer value
171.20
it :: Price
>
```
### OrderItem

```Haskell
> :set -XOverloadedStrings
-- here's some csv bytestring:
> bs = "label,unit price,quantity,buyer\nStaples,0.50,100,Desmond\nPaper,1.78,25,Clara"
>
> -- decoding the csv
> rs = decodeByName bs :: Either String (Header, Vector OrderItem)
Right (["label","unit price","quantity","buyer"]
      ,[OrderItem {label = "Staples", unitPrice = 0.50, quantity = 100, buyer = "Desmond"}
       ,OrderItem {label = "Paper", unitPrice = 1.78, quantity = 25, buyer = "Clara"}])
>
> -- getting the buyer and total price of each record
> (Data.Vector.map (\o -> (buyer o, totalPrice o)) . snd)
Right [("Desmond",50.00),("Clara",44.50)]
```
## Cascaded Rounding


```Haskell
> ns = [10/7 | x <-[1..7]]
> ns
[1.4285714285714286,1.4285714285714286,1.4285714285714286,1.4285714285714286,1.4285714285714286,1.4285714285714286,1.4285714285714286]
> cascadeRound ns
[1,2,1,2,1,2,1]
>
> ns = [100/7 | x <-[1..7]]
> cascadeRound ns
[14,15,14,14,14,15,14]
> ns = [100/3 | x <-[1..3]]
> ns
[33.333333333333336,33.333333333333336,33.333333333333336]
> cascadeRound ns
[33,34,33]
>
> ns = map (*100) [39.977291,19.1891,490.388109,95.9455]
> map ((/100).fromIntegral) $ cascadeRound ns
[39.98,19.19,490.38,95.95]
```

### BillItem


```Haskell
> :set -XOverloadedStrings
> os=[OrderItem "staples" (price 0.50) 100 "Clara", OrderItem "paper" (price 1.75) 50 "Clara", OrderItem "pencils" (price 0.25) 100 "Clara"]
> bi = billItem os
> bi
BillItem {buyer = "Clara", total = 162.50}
> encodeByName billItemsHeader [bi]
"buyer,total\r\nClara,162.50\r\n"
it :: Data.ByteString.Lazy.Internal.ByteString
```
