module Money
    where

import Data.Fixed

data Money = Money { value :: Integer }
    deriving (Eq)

instance Num Money where
    m * n = Money ((value m) * (value n) `div` 100)

instance Show Money where
    show (Money value) = show (MkFixed value :: Centi)

money :: Double -> Money
money = Money . round . (* 100)

times :: Integer -> Money -> Money
times n m = m * (money (fromIntegral n))

