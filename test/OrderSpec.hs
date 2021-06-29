{-# LANGUAGE OverloadedStrings #-}
module OrderSpec
    where

import Test.Hspec
import Order
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector
import Data.Csv

spec :: SpecWith ()
spec = do
    describe "Order" $ do
        it "can be read from a csv ByteString" $ do
            let csv = BS.unlines ["item,unitp,qty,amount,buyer"
                                 ,"pencils           ,  0.50 , 20  ,  10.00 , Bertrand"]
                result = decodeByName csv
            result `shouldBe`
                Right (fromList ["item","unitp","qty","amount","buyer"]
                      ,fromList [Order { item = "pencils"
                                       , unitPrice = 0.50
                                       , quantity = 20
                                       , buyer = "Bertrand" }])

