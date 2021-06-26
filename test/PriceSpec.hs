module PriceSpec
    where

import Test.Hspec
import Price

spec :: SpecWith ()
spec = do
    describe "a Price" $ do
        it "can be created from a float and have in integer value" $ do
            let p = price 48.07
            value p `shouldBe` 4807

        it "can be shown as a fixed precision" $ do
            let p = price 48.07
            show p `shouldBe` "48.07"

        it "rounded to the cent when created from a float" $ do
            value (price 17.994) `shouldBe` 1799
            value (price 17.996) `shouldBe` 1800

        it "can be multiplied by an integer value" $ do
            let p = (price 48.07) `times` 4
            show p `shouldBe` "192.28"

        it "can be converted to a float" $ do
            fromPrice (price 48.07) `shouldBe` 48.07

