{-# LANGUAGE RecordWildCards #-}
module GroupPurchase
    where

import Order
import Amount
import Bill
import Data.Csv
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector
import Data.List as L
import Data.Function
import Data.Ord

process :: IO ()
process = do
    content <- BS.lines <$> BS.getContents
    let csv = BS.unlines (Prelude.filter (\s -> BS.head s /= '~') content)
        result  = toList <$> snd <$> decodeOrders csv
    case result of
        Left msg -> Prelude.putStrLn msg
        Right orders -> do
            let bills = Prelude.map bill (groupByBuyer orders) 
            BS.putStrLn $ encodeBills bills


groupByBuyer :: [Order] -> [[Order]]
groupByBuyer = L.groupBy ((==) `on` Order.buyer) . sortBy (comparing Order.buyer)

bill :: [Order] -> Bill
bill [] = error "empty Order group"
bill os = Bill { buyer = Order.buyer (L.head os), amount = L.sum (L.map totalPrice os) }

