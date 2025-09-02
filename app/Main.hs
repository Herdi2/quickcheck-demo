module Main where
import Part1
import Part2
import Part3
import Part4
import Test.Hspec
import Test.Hspec.QuickCheck

main :: IO ()
main = putStrLn "Hello, Haskell!"

data QInfo = QuickCheck {getInfo :: IO (), devops :: IO (), takeaway :: IO ()}

quickCheck :: QInfo
quickCheck =
  QuickCheck
  {
    getInfo = putStrLn $ "Authors: John Hughes, Koen Claessen (2000)\n"
            ++"Paper cited over 1900 times, introduced Property-based testing",
    devops = putStrLn $ "+ Automates test-writing\n"
              ++"+ Scalable\n"
              ++"- Doesn't always find counter-examples",
    takeaway = putStrLn "Property-based testing allows for abstraction, scalability and easier automation!"
  }