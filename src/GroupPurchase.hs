{-# LANGUAGE RecordWildCards #-}
module GroupPurchase
    where

import Order as O
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
            let bills = Prelude.map billFromOrders (groupByBuyer orders)
            BS.putStrLn $ encodeBills bills

groupPurchase :: [Order] -> [Bill]
groupPurchase orders = Prelude.map billFromOrders (groupByBuyer orders)

groupByBuyer :: [Order] -> [[Order]]
groupByBuyer = L.groupBy ((==) `on` O.buyer) . sortBy (comparing O.buyer)

billFromOrders :: [Order] -> Bill
billFromOrders [] = error "empty Order group"
billFromOrders os = bill (O.buyer (L.head os)) (L.sum (L.map (fromAmount . totalPrice) os))

