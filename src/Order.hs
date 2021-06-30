{-# LANGUAGE OverloadedStrings #-}
module Order
    where

import Data.Text
import Item
import Data.Csv
import Data.Vector
import Data.ByteString.Lazy.Char8 as BS


data Order = Order { item :: Item
                   , unitPrice :: Double
                   , quantity :: Integer
                   , buyer :: Text }
    deriving (Eq, Show)

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
