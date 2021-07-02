{-# LANGUAGE RecordWildCards #-}
module Order
    where

import Money
import Data.Text

data Order = Order { item :: Text
                   , unitPrice :: Money
                   , quantity :: Integer
                   , buyer :: Text }

order :: Text -> Double -> Integer -> Text -> Order
order i u q b = Order i (money u) q b

totalPrice :: Order -> Money
totalPrice Order { .. } = quantity `times` unitPrice


