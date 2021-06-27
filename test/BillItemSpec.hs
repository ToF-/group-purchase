{-# LANGUAGE OverloadedStrings #-}
module BillItemSpec
    where

import Test.Hspec
import BillItem as B
import OrderItem as O
import Price
import Data.Vector
import Data.Csv

spec :: SpecWith ()
spec = do
    describe "a Bill Item" $ do
        it "is created from a group or Order Items with the same buyer" $ do
            let os = [OrderItem { label = "pencils"
                                , unitPrice = price 0.50
                                , quantity = 20
                                , O.buyer = "Bertrand"}
                     ,OrderItem { label = "staples"
                                , unitPrice = price 0.25
                                , quantity = 100
                                , O.buyer = "Bertrand"}
                     ,OrderItem { label = "paper"
                                , unitPrice = price 1.75
                                , quantity = 30
                                , O.buyer = "Bertrand"}]
            billItem os `shouldBe` BillItem { B.buyer = "Bertrand", total = price 87.50 }

        it "can be converted into a CSV record" $ do
            let items = [BillItem { B.buyer = "Alice", total = price 14.50 }
                        ,BillItem { B.buyer = "Bertrand", total = price 87.50 }
                        ,BillItem { B.buyer = "Clara", total = price 650.00 }]
                csv = encodeByName billItemsHeader items
            csv `shouldBe` "buyer,total\r\nAlice,14.50\r\nBertrand,87.50\r\nClara,650.00\r\n"
