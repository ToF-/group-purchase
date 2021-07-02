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
        it "applies a shipping fee proportionally to each buyer's amont" $ do
            let bills = [bill "Bertrand" 10.0
                        ,bill "Clara" 70.0
                        ,bill "Desmond" 20.0]
            applyShipping (money 10.0) bills `shouldBe`
                [bill "Bertrand" 11.0
                ,bill "Clara" 77.0
                ,bill "Desmond" 22.0]
