{-# LANGUAGE OverloadedStrings #-}
module OrderItem
    where

import Price
import Data.Csv
import Data.ByteString.Char8

data OrderItem = OrderItem {
    label :: ByteString,
    unitPrice :: Price,
    quantity :: Integer,
    buyer :: ByteString }
    deriving(Eq, Show)

instance FromNamedRecord OrderItem where
    parseNamedRecord r = OrderItem <$> (strip <$> (r .: "label"))
                                   <*> r .: "unit price"
                                   <*> r .: "quantity"
                                   <*> (strip <$> (r .: "buyer"))

totalPrice :: OrderItem -> Price
totalPrice item = unitPrice item `times` quantity item

