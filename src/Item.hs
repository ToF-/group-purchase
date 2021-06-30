{-# LANGUAGE OverloadedStrings #-}
module Item
    where

import Data.Text
import Data.Text.Encoding
import Data.Csv
import Data.ByteString.Lazy.Char8 as BS

data Item = Item { label :: Text }
    deriving (Eq, Show)

instance FromField Item
    where parseField f = case runParser (parseField f :: Parser Text) of
                           Left err -> fail err
                           Right t -> case strip t of
                                        "" -> fail "empty Item field"
                                        l  -> pure $ Item l
