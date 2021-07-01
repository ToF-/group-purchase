{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-} 
module Order
    where

import Data.Text
import Item
import Amount
import Data.Csv
import Data.Vector
import Data.ByteString.Lazy.Char8 as BS


data Order = Order { item :: Item
                   , unitPrice :: Amount
                   , quantity :: Integer
                   , buyer :: Text }
    deriving (Eq, Show)

order :: Text -> Double -> Integer -> Text -> Order
order i u q b = Order { item = Item i
                      , unitPrice = amount u
                      , quantity = q
                      , buyer = b }

totalPrice :: Order -> Amount
totalPrice Order { .. } = unitPrice * (amount (fromIntegral quantity))

instance FromNamedRecord Order
    where parseNamedRecord r = Order <$> (r .: "item")
                                     <*> r .: "unitp"
                                     <*> r .: "qty"
                                     <*> (strip <$> r.: "buyer")

decodeOrders :: ByteString -> Either String (Header, Vector Order)
decodeOrders = decodeByName 
    . BS.unlines
    . Prelude.filter (\l -> not (BS.null l) && BS.head l /= '~')
    . BS.lines
