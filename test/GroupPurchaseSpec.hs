{-# LANGUAGE OverloadedStrings #-}
module GroupPurchaseSpec
    where

import Bill
import GroupPurchase
import Money (money)
import Test.Hspec

spec :: SpecWith ()
spec = do
    describe "GroupPurchase" $ do
        it "applies a shipping fee proportionally to each buyer's amount" $ do
            let bills = [bill "Bertrand" 10.0
                        ,bill "Clara" 70.0
                        ,bill "Desmond" 20.0]
            applyShipping (money 10.0) bills `shouldBe`
                [bill "Bertrand" 11.0
                ,bill "Clara" 77.0
                ,bill "Desmond" 22.0]

        it "adjusts amounts so that the sum of amounts equals the total" $ do
            let bills = [bill "Bertrand" 33.0
                        ,bill "Clara" 33.0
                        ,bill "Desmond" 33.0]
            applyShipping (money 1.0) bills `shouldBe`
                [bill "Bertrand" 33.33
                ,bill "Clara" 33.34
                ,bill "Desmond" 33.33]

