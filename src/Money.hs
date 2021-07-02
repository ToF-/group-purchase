module Money
    where

data Money = Money { value :: Integer }
    deriving (Eq, Show)

instance Num Money where
    m * n = Money ((value m) * (value n) `div` 100)

money :: Double -> Money
money = Money . round . (* 100)

times :: Integer -> Money -> Money
times n m = m * (money (fromIntegral n))

