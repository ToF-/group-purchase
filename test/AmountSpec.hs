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

        it "can be extracted as a double" $ do
            fromAmount (amount 48.07) `shouldBe` 48.07

        it "can be multiplied" $ do
            (amount 48.07) * (amount 42.17) `shouldBe` amount 2027.11
