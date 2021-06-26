{-# LANGUAGE OverloadedStrings #-}

module OrderItemSpec
    where

import Test.Hspec
import OrderItem
import Price
import Data.Csv
import Data.ByteString.Lazy (ByteString)
import Data.Vector

spec :: SpecWith ()
spec = do
    describe "an Order Item" $ do
        let item = OrderItem "Staples" (price 0.55) 100 "Desmond"
        it "has a label, a unit price, a quantity, and a buyer" $ do
            label item `shouldBe` "Staples"
            unitPrice item `shouldBe` price 0.55
            quantity item `shouldBe` 100
            buyer item `shouldBe` "Desmond"

        it "has a total price equal to unit price X quantity" $ do
            totalPrice item `shouldBe` price 55.00


        it "can be converted from a CSV record" $ do
            let csv = "label,unit price,quantity,buyer\n  pencils           ,  0.50    ,  20    ,  Bertrand  \n"
                result = decodeByName csv
            result `shouldBe`
                Right (fromList ["label","unit price","quantity","buyer"],
                fromList [OrderItem { label = "pencils"
                                    , unitPrice = price 0.50
                                    , quantity = 20
                                    , buyer = "Bertrand"}])


