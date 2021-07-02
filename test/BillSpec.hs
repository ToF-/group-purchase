{-# LANGUAGE OverloadedStrings #-}
module BillSpec
    where

import Bill
import Money
import Order (order)
import Test.Hspec

spec :: SpecWith ()
spec = do
    describe "Bill" $ do
        it "has a buyer, and an amount" $ do
            let b = bill "Bertrand" 48.70
            buyer b `shouldBe` "Bertrand"
            amount b `shouldBe` money 48.70

        it "is created from a group of Orders with same buyer" $ do
            let orders = [order "staples" 0.5 10 "Bertrand"
                         ,order "paper"   7.0 3 "Bertrand"
                         ,order "pencil"  0.25 4 "Bertrand"]
            fromOrders orders `shouldBe` bill "Bertrand" 27.0
