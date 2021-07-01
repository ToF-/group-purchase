{-# LANGUAGE RecordWildCards #-}
module GroupPurchase
    where

import Order as O
import Total as T
import Amount as A
import Bill as B
import Data.Csv
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector
import Data.List as L
import Data.Function
import Data.Ord
import CascadeRound

process :: IO ()
process = do
    content <- BS.lines <$> BS.getContents
    let (csvOrders,csvTotals) = L.partition (\s -> BS.head s /= '~') content
        decodedOrders  = toList <$> snd <$> decodeOrders (BS.unlines csvOrders)
        decodedTotals  = toList <$> decodeTotals (BS.unlines csvTotals)

    case decodedOrders of
        Left msg -> Prelude.putStrLn msg
        Right orders -> do
            case decodedTotals of
              Left msg -> Prelude.putStrLn msg
              Right totals -> do
                let shipping = fromAmount $ T.amount $ L.head $  totals
                    bills = groupPurchaseWithShipping orders shipping
                BS.putStrLn $ encodeBills bills

groupPurchase :: [Order] -> [Bill]
groupPurchase orders = Prelude.map billFromOrders (groupByBuyer orders)

groupPurchaseWithShipping :: [Order] -> Double -> [Bill]
groupPurchaseWithShipping orders shipping = L.zipWith B.setAmount bills adjustedAmounts
    where
        bills = groupPurchase orders
        adjustedAmounts = roundedAmounts amountsWithShipping
        amountsWithShipping = L.map (\m -> m * (1 + shipping / total)) amounts
        amounts = L.map (fromAmount . B.amount) bills
        total = L.sum amounts
        roundedAmounts = L.map ((/100).fromIntegral) . cascadeRound . L.map (*100)

groupByBuyer :: [Order] -> [[Order]]
groupByBuyer = L.groupBy ((==) `on` O.buyer) . sortBy (comparing O.buyer)

billFromOrders :: [Order] -> Bill
billFromOrders [] = error "empty Order group"
billFromOrders os = bill (O.buyer (L.head os)) (L.sum (L.map (fromAmount . totalPrice) os))

