module Amount
    where

import Data.Fixed
import Data.Csv
import Data.ByteString.Char8

data Amount = Amount { value :: Integer }
    deriving (Eq)

instance Show Amount
    where show a = show (MkFixed (value a) :: Centi)

instance ToField Amount
    where toField = pack . show
