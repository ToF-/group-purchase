{-# LANGUAGE DeriveGeneric #-}
module Price
where

import Data.Fixed
import Data.Csv
import GHC.Generics

data Price = Price { value :: Integer }
    deriving (Eq)

instance Show Price
    where show p = show (MkFixed (value p) :: Centi)

instance FromField Price
    where parseField t = price <$> (parseField t :: Parser Double)

price :: Double -> Price
price a = Price { value = round (a * 100) }

times :: Price -> Integer -> Price
times p q = p { value = value p * q }

fromPrice :: Price -> Double
fromPrice p = fromIntegral (value p) / 100
