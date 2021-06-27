{-# LANGUAGE OverloadedStrings #-}
module GroupPurchaseSpec
    where

import Test.Hspec
import GroupPurchase
import Data.ByteString.Char8 as BS


spec :: SpecWith ()
spec = do
    describe "groupPurchase" $ do
        it "given a input csv filename and a csv output filename, produces the buyers parts and total" $ do
            let bsInput = BS.unlines ["label,unit price,quantity,total,buyer"
                                     ,"pencils           ,  0.50    ,  20    ,10.00, Bertrand"
                                     ,"paper             ,  1.50    ,  25    ,37.50, Alice"
                                     ,"paper             ,  1.80    ,  50    , 90.00 , Desmond"
                                     ,"laundry detergent ,  2.00    ,  10    ,20.00 , Clara"
                                     ,"trash bags        ,  4.30    ,  100   ,430.00 , Clara"
                                     ,"gift cards        ,  8.00    ,  1     ,8.00 ,Bertrand"
                                     ,"lightbulbs        ,  1.00    ,  10    ,10.00 , Clara"
                                     ,"~ shipping        , 40.00    ,  1     ,40.00 , ~ shipping"]
            BS.writeFile "data/input.csv" bsInput
            groupPurchase "data/input.csv" "data/output.csv"
            bsOutput <- BS.readFile "data/output.csv"
            BS.lines bsOutput  `shouldBe`
                ["buyer,total\r","Alice,39.98\r","Bertrand,19.19\r","Clara,490.38\r","Desmond,95.95\r","~ total,645.50\r"]


