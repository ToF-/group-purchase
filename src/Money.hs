module Money
    where

data Money = Money { value :: Integer }
    deriving (Eq, Show)

money :: Double -> Money
money = Money . round

