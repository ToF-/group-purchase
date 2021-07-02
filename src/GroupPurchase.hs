module GroupPurchase
    where

import Bill
import CascadeRound
import Money
import Data.List as L

applyShipping :: Money -> [Bill] -> [Bill]
applyShipping shipping bills = L.zipWith setAmount bills withShippingRounded
    where
    setAmount :: Bill -> Double -> Bill
    setAmount b d = b { amount = money d }
    withShippingRounded = L.map ((/100).fromIntegral) $ cascadeRound $ L.map (*100) withShipping
    withoutShipping = L.map (asDouble . amount) bills
    total = L.sum withoutShipping
    fee = asDouble shipping
    withShipping = L.map (\d -> d + (d / total * fee)) withoutShipping
