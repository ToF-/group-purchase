{-# LANGUAGE OverloadedStrings #-}
module OrderItem
    where

import Price
import Data.Csv
import Data.ByteString.Char8 as C8

data OrderItem = OrderItem {
    label :: String,
    unitPrice :: Price,
    quantity :: Integer,
    buyer :: String }
    deriving(Eq, Show)

instance FromNamedRecord OrderItem where
    parseNamedRecord r = OrderItem <$> ((C8.unpack. C8.strip) <$> (r .: "label"))
                                   <*> r .: "unit price"
                                   <*> r .: "quantity"
                                   <*> ((C8.unpack . C8.strip) <$> (r .: "buyer"))

totalPrice :: OrderItem -> Price
totalPrice item = unitPrice item `times` quantity item

