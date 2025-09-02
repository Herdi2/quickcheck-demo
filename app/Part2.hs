{-# LANGUAGE ScopedTypeVariables #-}
module Part2 where
import Test.Hspec
import Test.Hspec.QuickCheck

{-

Intro: Property-based testing

Automated testing method - generate the tests!
 -}

reverse2 :: [Int] -> [Int]
reverse2 [] = []
reverse2 (x : xs)
  | x == 42 = reverse2 xs
  | otherwise = reverse2 xs ++ [x]

prop_rev2_ident :: [Int] -> Expectation
prop_rev2_ident list = (reverse2 . reverse2) list `shouldBe` list

prop_reverse_empty :: SpecWith()
prop_reverse_empty =
  describe "Testing reverse' on list" $ do
    modifyMaxSuccess (const 3) $
      prop "Testing identity property" $
        \list -> prop_rev2_ident list
