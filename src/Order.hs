module Order
    where

import Data.Text

data Order = Order { item :: Text
                   , unitPrice :: Double
                   , quantity :: Integer
                   , buyer :: Text }

order :: Text -> Double -> Integer -> Text -> Order
order i u q b = Order i u q b
