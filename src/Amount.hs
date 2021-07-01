module Amount
    where

import Data.Fixed
import Data.Csv
import Data.ByteString.Char8

data Amount = Amount { value :: Integer }
    deriving (Eq)

amount :: Double -> Amount
amount d = Amount { value = round (d*100) }

instance Show Amount
    where show a = show (MkFixed (value a) :: Centi)

instance ToField Amount
    where toField = pack . show
