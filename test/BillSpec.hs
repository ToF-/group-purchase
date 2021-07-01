{-# LANGUAGE OverloadedStrings #-}
module BillSpec
    where

import Test.Hspec
import Bill
import Amount
import Data.ByteString.Lazy.Char8 as BS
import Data.Vector
import Data.Csv

spec :: SpecWith ()
spec = do
    describe "Bill" $ do
        it "can be written into a csv" $ do
            let ls = [bill "Bertrand" 42.17
                     ,bill "Clara" 403.99]

            encodeBills ls `shouldBe`
                "buyer,amount\r\nBertrand,42.17\r\nClara,403.99\r\n"


