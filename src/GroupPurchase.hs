module GroupPurchase
    where

import Order
import Amount
import Bill
import Data.Csv
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector

process :: IO ()
process = do
    content <- BS.lines <$> BS.getContents
    let csv = BS.unlines (Prelude.filter (\s -> BS.head s /= '~') content)
        result  = toList <$> snd <$> decodeOrders csv
    case result of
        Left msg -> Prelude.putStrLn msg
        Right orders -> do
            let bills = Prelude.map (\o -> Bill { Bill.buyer = Order.buyer o,
                                                  Bill.amount = (Amount.amount (fromIntegral (Order.quantity o))) * Order.unitPrice o }) orders
            BS.putStrLn $ encodeBills bills
