module Part1 where
import Test.Hspec

reverse1 :: [a] -> [a]
reverse1 [] = []
reverse1 (x : xs) = reverse1 xs ++ [x]

-- Manually writing tests

test1 :: SpecWith ()
test1 = describe "Testing reverse1 on lists" $ do
        it "Reverse empty list" $ reverse1 ([] :: [Int]) `shouldBe` []
        it "Reverse small list" $ reverse1 ([1,2,3] :: [Int]) `shouldBe` [3,2,1]