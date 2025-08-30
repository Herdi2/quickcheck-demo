{-# LANGUAGE ScopedTypeVariables #-}
module Part2 where
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck

reverse2 :: [a] -> [a]
reverse2 [] = []
reverse2 (x : xs) = reverse2 xs ++ [x]
  -- | length xs > 10 = reverse2 xs
  -- | otherwise = reverse2 xs ++ [x]

prop_reverse_empty :: SpecWith()
prop_reverse_empty =
  describe "Testing reverse' on list" $ do
    prop "Testing identity property" $
      \(list :: [Int]) -> reverse2 (reverse2 list) `shouldBe` list
