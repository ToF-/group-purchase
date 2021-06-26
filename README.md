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
We need a specific type for _prices_:

A price can be shown as a fixed precision number
A price is created from a double value that is rounded with a resolution of 100

let p = price 28.795
show p = "28.80"

A price can be multiplied by an integral value (so that we can multiply unit price by quantity)

p `times` 4 == Price 115.16

One can extract the floating value from a price (so that we can calculate each buyer's part of the shipping fee)

let p = price 28.79
fromPrice p == 28.79

