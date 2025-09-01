module Part1 where
import Test.Hspec

-- | User-defined reverse list implementation
reverse1 :: [Int] -> [Int]
reverse1 [] = []
reverse1 (x : xs)
  | x == 42 = reverse1 xs
  | otherwise = reverse1 xs ++ [x]

-- | Manually writing tests
test1 :: SpecWith ()
test1 = describe "Testing reverse1 on lists" $ do
        it "Reverse empty list" $ reverse1 [] `shouldBe` []
        it "Reverse small list" $ reverse1 [1,2,3] `shouldBe` [3,2,1]