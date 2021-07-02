{-# LANGUAGE OverloadedStrings #-}
module BillSpec
    where

import Bill
import Money
import Test.Hspec

spec :: SpecWith ()
spec = do
    describe "Bill" $ do
        it "has a buyer, and an amount" $ do
            let b = bill "Bertrand" 48.70
            buyer b `shouldBe` "Bertrand"
            amount b `shouldBe` money 48.70

