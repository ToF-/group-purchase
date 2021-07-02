module GroupPurchase
    where

import Bill
import Money
import Data.List as L

applyShipping :: Money -> [Bill] -> [Bill]
applyShipping shipping bills = L.zipWith setAmount bills withShipping
    where
    setAmount :: Bill -> Double -> Bill
    setAmount b d = b { amount = money d }
    withoutShipping = L.map (asDouble . amount) bills
    total = L.sum withoutShipping
    fee = asDouble shipping
    withShipping = L.map (\d -> d + (d / total * fee)) withoutShipping
