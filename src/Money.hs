module Money
    where

import Data.Fixed

data Money = Money { value :: Integer }
    deriving (Eq)

instance Num Money where
    m * n = Money ((value m) * (value n) `div` 100)
    m + n = Money ((value m) + (value n))

instance Show Money where
    show (Money value) = show (MkFixed value :: Centi)

money :: Double -> Money
money = Money . round . (* 100)

times :: Integer -> Money -> Money
times n m = m * (money (fromIntegral n))

asDouble :: Money -> Double
asDouble = (/100) . fromIntegral . value
