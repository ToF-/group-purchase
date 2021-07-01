{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Total
    where

import Amount as A
import Data.Csv
import Data.Text
import Data.Vector
import Data.ByteString.Lazy.Char8 as BS

data Total = Total { label :: Text
                   , amount :: Amount }
    deriving (Eq, Show)

instance FromRecord Total
    where parseRecord v = Total <$> v .! 0 <*> v .! 1

decodeTotals :: ByteString -> Either String (Vector Total)
decodeTotals = decode NoHeader

