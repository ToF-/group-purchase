{-# LANGUAGE OverloadedStrings #-}
module OrderSpec
    where

import Amount
import Data.ByteString.Lazy.Char8 as BS
import Data.Csv
import Data.Vector
import Item
import Order
import Test.Hspec

spec :: SpecWith ()
spec = do
    describe "Order" $ do
        let expectedHeader = fromList ["item","unitp","qty","amount","buyer"]

        it "can be read from a csv ByteString" $ do
            let csv = BS.unlines ["item,unitp,qty,amount,buyer"
                                 ,"pencils           ,  0.50 , 20  ,  10.00 , Bertrand"]
            decodeOrders csv `shouldBe`
                Right (expectedHeader,
                       fromList [Order { item = Item "pencils"
                                       , unitPrice = amount 0.50
                                       , quantity = 20
                                       , buyer = "Bertrand" }])

        it "can't be created from a csv record with an item starting with ~" $ do
            let csv = BS.unlines ["item,unitp,qty,amount,buyer"
                                 ,"~ total, , , 10.00, "]
            decodeOrders csv `shouldBe` Right (expectedHeader, fromList[])

        it "can't be created from a csv record with an empty item" $ do
            let csv = BS.unlines ["item,unitp,qty,amount,buyer"
                                 ,""
                                 ,",1 ,1 , 10.00, "]
            decodeOrders csv `shouldBe`
                Left "parse error (Failed reading: conversion error: empty Item field) at \"\\n\""

        it "can be created from a csv file where ~ records are filtered out" $ do
            let csv = BS.unlines ["item,unitp,qty,amount,buyer"
                                 ,"pencils           ,  0.50 , 20  ,  10.00 , Bertrand"
                                 ,"~ shipping        , 30.00 , 1   ,        , "]
            decodeOrders csv `shouldBe`
                Right (expectedHeader,
                       fromList [Order { item = Item "pencils"
                                       , unitPrice = amount 0.50
                                       , quantity = 20
                                       , buyer = "Bertrand" }])

