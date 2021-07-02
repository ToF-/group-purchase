module Bill
    where

import Money
import Order (Order)
import qualified Order as O
import Data.List as L
import Data.Text

data Bill = Bill { buyer :: Text
                 , amount :: Money }
    deriving (Eq, Show)

bill :: Text -> Double -> Bill
bill b a = Bill b (money a)

fromOrders :: [Order] -> Bill
fromOrders [] = error "can't create a bill for empty group of orders"
fromOrders orders = Bill (O.buyer (L.head orders))
                         (L.foldl (+) (money 0) (L.map O.totalPrice orders))
