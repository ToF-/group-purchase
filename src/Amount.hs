{-# LANGUAGE RecordWildCards #-}

module Amount
    where

import Data.Fixed
import Data.Csv
import Data.ByteString.Char8

data Amount = Amount { value :: Integer }
    deriving (Eq)

amount :: Double -> Amount
amount d = Amount { value = round (d*100) }

fromAmount :: Amount -> Double
fromAmount Amount { .. } = (fromIntegral value) / 100

instance Show Amount
    where show a = show (MkFixed (value a) :: Centi)

instance ToField Amount
    where toField = pack . show

instance FromField Amount
    where parseField = fmap amount . parseField

instance Num Amount
    where a * b = amount (fromAmount a * fromAmount b)
