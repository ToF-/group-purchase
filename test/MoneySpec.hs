module MoneySpec
    where

import Test.Hspec
import Money

spec :: SpecWith ()
spec = do
    describe "Money" $ do
        it "can be made from a double, rounded to a cent" $ do
            money 42.173 `shouldBe` money 42.17
            money 48.179 `shouldBe` money 48.18

        it "shows as fixed decimals number" $ do
            show (money 48.00) `shouldBe` "48.00"

        it "can be extracted as a double" $ do
            asDouble (money 48.07) `shouldBe` 48.07
