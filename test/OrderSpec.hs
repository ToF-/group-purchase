{-# LANGUAGE OverloadedStrings #-}
module OrderSpec
    where

import Test.Hspec
import Order

spec :: SpecWith ()
spec = do
    describe "Order" $ do
        it "has an item, a unit price, a quantity and a buyer" $ do
            let o = order "staples" 0.50 10 "Bertrand"
            item o `shouldBe` "staples"
            unitPrice o `shouldBe` 0.50
            quantity o `shouldBe` 10
            buyer o `shouldBe` "Bertrand"
