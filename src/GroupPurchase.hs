module GroupPurchase
    where

import Order
import Data.Csv
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector

process :: IO ()
process = do
    content <- BS.lines <$> BS.getContents
    let csv = BS.unlines (Prelude.filter (\s -> BS.head s /= '~') content)
    print $  (decodeByName csv :: Either String (Header,Vector Order))
