module AmountSpec
    where

import Test.Hspec
import Amount

spec :: SpecWith ()
spec = do
    describe "Amount" $ do 
        it "can be created from a double" $ do 
            amount 48.07 `shouldBe` Amount 4807

        it "shows as a Fixed number with 2 decimal places" $ do
            show (amount 48.07) `shouldBe` "48.07" 
