{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Bill
    where

import Amount as A
import Data.Csv
import Data.Text
import Data.Vector
import Data.ByteString.Lazy.Char8 as BS

data Bill = Bill { buyer :: Text
                 , amount :: Amount }
    deriving (Eq, Show)

bill :: Text -> Double -> Bill
bill t a = Bill t (A.amount a)

setAmount :: Bill -> Double -> Bill
setAmount b d = b { Bill.amount = A.amount d }

billHeader :: Header
billHeader = fromList ["buyer","amount"]

instance ToNamedRecord Bill
    where
        toNamedRecord Bill { .. } =
            namedRecord ["buyer"  .= buyer 
                        ,"amount" .= amount]

encodeBills :: [Bill] -> ByteString
encodeBills bs = encodeByName billHeader bs
