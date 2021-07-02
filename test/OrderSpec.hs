{-# LANGUAGE OverloadedStrings #-}
module OrderSpec
    where

import Money
import Order
import Test.Hspec

spec :: SpecWith ()
spec = do
    describe "Order" $ do
        it "has an item, a unit price, a quantity and a buyer" $ do
            let o = order "staples" 0.50 10 "Bertrand"
            item o `shouldBe` "staples"
            unitPrice o `shouldBe` money 0.50
            quantity o `shouldBe` 10
            buyer o `shouldBe` "Bertrand"

        it "can tell its total price" $ do
            let o = order "staples" 0.50 10 "Bertrand"
            totalPrice o `shouldBe` money 5.0
