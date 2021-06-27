module GroupPurchase
    where

import System.FilePath
import Data.ByteString.Char8 as C8
import Data.ByteString.Lazy as BS
import Data.Csv
import qualified OrderItem as O
import qualified BillItem as B
import Data.Vector (toList, Vector)
import qualified Data.List as L

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
        bills = Prelude.map B.billItem groups
    in bills

