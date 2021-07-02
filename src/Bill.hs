module Bill
    where

import Money
import Data.Text

data Bill = Bill { buyer :: Text
                 , amount :: Money }
    deriving (Eq)

bill :: Text -> Double -> Bill
bill b a = Bill b (money a)
