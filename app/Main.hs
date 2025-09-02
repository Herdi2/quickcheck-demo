module Main where
import Part1
import Part2
import Part3
import Part4
import Test.Hspec
import Test.Hspec.QuickCheck

main :: IO ()
main = putStrLn "Hello, Haskell!"

data QInfo = QuickCheck {getInfo :: IO (), positives :: IO (), negatives :: IO (), takeaway :: IO ()}

quickCheck :: QInfo
quickCheck =
  QuickCheck
  {
    getInfo = putStrLn $ "Authors: John Hughes, Koen Claessen (2000)\n"
            ++"Paper cited over 1900 times, introduced Property-based testing",
    positives = putStrLn $ "+ Automates test-writing\n"
              ++"+ Scalable\n"
              ++"+ Broader test coverage",
    negatives = putStrLn $ "- Difficulty in expressing properties\n"
              ++"- False sense of security",
    takeaway = putStrLn "Property-based testing allows abstraction, scalability and easier automation!"
  }