{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Bill
    where

import Amount
import Data.Csv
import Data.Text
import Data.Vector
import Data.ByteString.Lazy.Char8 as BS

data Bill = Bill { buyer :: Text
                 , amount :: Amount }
    deriving (Eq, Show)

billHeader :: Header
billHeader = fromList ["buyer","amount"]

instance ToNamedRecord Bill
    where
        toNamedRecord Bill { .. } =
            namedRecord ["buyer"  .= buyer 
                        ,"amount" .= amount]

encodeBills :: [Bill] -> ByteString
encodeBills bs = encodeByName billHeader bs
