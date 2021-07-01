{-# LANGUAGE OverloadedStrings #-}
module GroupPurchaseSpec
    where

import Test.Hspec
import qualified Amount as A
import Item
import Bill
import qualified Bill as B
import Order
import qualified Order as O
import GroupPurchase

spec :: SpecWith ()
spec = do
    describe "groupPurchase" $ do
        it "convert Orders into Bills" $ do
            let orders =  [order "pencils" 0.50 20  "Bertrand"
                          ,order "staples" 0.75 100 "Clara"
                          ,order "paper"   1.50 200 "Alice"
                          ,order "thrash can" 5.24 1 "Clara"
                          ,order "scissors" 3.00 1 "Desmond"
                          ,order "duct tape" 1.00 10 "Bertrand"]

            groupPurchase orders `shouldBe` [bill "Alice" 300.00
                                            ,bill "Bertrand" 20.00
                                            ,bill "Clara" 80.24
                                            ,bill "Desmond" 3.00]
