{-# LANGUAGE OverloadedStrings #-}
module Order
    where

import Data.Text
import Data.Csv

data Order = Order { item :: Text
                   , unitPrice :: Double
                   , quantity :: Integer
                   , buyer :: Text }
    deriving (Eq, Show)

instance FromNamedRecord Order
    where parseNamedRecord r = Order <$> (strip <$> r .: "item")
                                     <*> r .: "unitp"
                                     <*> r .: "qty"
                                     <*> (strip <$> r.: "buyer")
