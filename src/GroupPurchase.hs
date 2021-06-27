{-# LANGUAGE OverloadedStrings #-}
module GroupPurchase
    where

import System.FilePath
import Data.ByteString.Char8 as C8
import Data.ByteString.Lazy as BS
import Data.Csv
import CascadeRound
import qualified OrderItem as O
import qualified BillItem as B
import Data.Vector (toList, Vector)
import qualified Data.List as L
import qualified Price as P

groupPurchase :: FilePath -> FilePath -> IO ()
groupPurchase fpIn fpOut = do
    ordersCsv <- BS.readFile fpIn
    let result = decodeByName ordersCsv
    case result of
      Left msg -> Prelude.putStrLn msg
      Right (_,orders) -> do
          let bills = computeGroupPurchase (toList orders)
              billsCsv = encodeByName B.billItemsHeader bills
          BS.writeFile fpOut billsCsv


computeGroupPurchase :: [O.OrderItem] -> [B.BillItem]
computeGroupPurchase orders =
    let (shipping,items) = L.partition (('~' ==) . C8.head . O.label) orders
        sortedItems = L.sortBy (\i j -> compare (O.buyer i) (O.buyer j)) items
        groups = L.groupBy (\i j -> O.buyer i == O.buyer j) sortedItems
        bills = L.map B.billItem groups
        totals = L.map ((* 100). P.fromPrice . B.total) bills
        total  = L.sum totals
        fee = 100 * P.fromPrice (O.unitPrice (L.head shipping))
        plusShips = L.map ((/ 100).fromIntegral) (cascadeRound (L.map (\t -> t + t / total * fee) totals))
        billsShip = L.zipWith (\b p -> b { B.total = P.price p }) bills plusShips
        totalShip = L.sum (L.map (P.fromPrice . B.total) billsShip)
    in billsShip <> [B.BillItem "~ total" (P.price totalShip)]

