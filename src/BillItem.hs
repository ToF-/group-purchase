{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module BillItem
    where

import OrderItem
import Price
import Data.ByteString.Char8 (ByteString)
import Data.Vector (fromList)
import Data.Csv

data BillItem = BillItem {
    buyer :: ByteString,
    total :: Price }
    deriving(Eq,Show)

instance ToNamedRecord BillItem
    where toNamedRecord BillItem {..} =
            namedRecord
            [ "buyer" .= buyer
            , "total" .= total ]

billItem :: [OrderItem] -> BillItem
billItem [] = error "evaluating billItem of an empty Order Item group"
billItem os = BillItem b t
    where
        b = OrderItem.buyer (head os)
        t = price (sum (map (fromPrice . totalPrice) os))

billItemsHeader :: Header
billItemsHeader = fromList ["buyer","total"]
