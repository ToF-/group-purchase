module CascadeRoundSpec
    where

import Test.Hspec
import Test.QuickCheck
import CascadeRound

spec :: SpecWith ()
spec = do
    describe "cascadeRound" $ do
        it "the sum of rounded parts is equal to the rounded total" $ property $
            \ns -> sum (cascadeRound ns)  `shouldBe` round (sum ns)
