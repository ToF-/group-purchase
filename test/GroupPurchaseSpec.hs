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
        let orders =  [order "pencils" 0.50 20  "Bertrand"
                      ,order "staples" 0.75 100 "Clara"
                      ,order "paper"   1.50 200 "Alice"
                      ,order "thrash can" 5.24 1 "Clara"
                      ,order "scissors" 3.00 1 "Desmond"
                      ,order "duct tape" 1.00 10 "Bertrand"]

        it "convert Orders into Bills" $ do
            groupPurchase orders `shouldBe` [bill "Alice" 300.00
                                            ,bill "Bertrand" 20.00
                                            ,bill "Clara" 80.24
                                            ,bill "Desmond" 3.00]

        it "distributes the shipping fee proportionally" $ do
            groupPurchaseWithShipping orders 40.00 `shouldBe` [bill "Alice" 329.76
                                                              ,bill "Bertrand" 21.98
                                                              ,bill "Clara" 88.20
                                                              ,bill "Desmond" 3.30]

        it "distributes the shipping fee with adjusted rounding" $ do
            let orders = [order "pencil" 10 3 "Bertrand"
                         ,order "paper"  10 3 "Alice"
                         ,order "staples" 10 3 "Clara"]
            groupPurchaseWithShipping orders 10 `shouldBe` [bill "Alice" 33.33
                                                           ,bill "Bertrand" 33.34
                                                           ,bill "Clara" 33.33]
