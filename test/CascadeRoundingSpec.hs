module CascadeRoundingSpec
    where

import Test.Hspec
import Test.QuickCheck
import CascadeRounding

spec :: SpecWith ()
spec = do
    describe "cascadeRounding" $ do
        it "the sum of rounded parts is equal to the rounded total" $ property $
            \ns -> sum (cascadeRounding ns)  `shouldBe` round (sum ns)
