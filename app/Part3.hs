module Part3 where
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck

-- | eDSL for defined arithmetic expressions
data Expr =
  Lit Int
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  deriving (Show, Eq)

eval :: Expr -> Int
eval (Lit i) = i
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2

simplify :: Expr -> Expr
simplify (Add (Lit 1) e) = e
simplify (Add e (Lit 0)) = e
simplify (Sub e (Lit 0)) = e
simplify (Mul _ (Lit 0)) = Lit 0
simplify (Mul (Lit 0) _) = Lit 0
simplify (Add e1 e2) = Add (simplify e1) (simplify e2)
simplify (Sub e1 e2) = Sub (simplify e1) (simplify e2)
simplify (Mul e1 e2) = Mul (simplify e1) (simplify e2)
simplify (Lit i) = Lit i

{-
Property: Preserve semantics
 -}

prop_simplify_preserve_semantics :: SpecWith()
prop_simplify_preserve_semantics =
  modifyMaxSuccess (const 1000) $
    prop "'simplify' preserves semantics" $
      \e -> eval e == eval (simplify e)
-- Wait, this doesn't work?




-- Haha! Property-based testing is GARBAGE!






-- Or is it?





instance Arbitrary Expr where
  arbitrary = sized $ \n ->
    if n <= 1 then
      Lit <$> arbitrary
    else
      oneof [
        Lit <$> arbitrary
        , Add <$> resize (div n 2) arbitrary <*> resize (div n 2) arbitrary
        , Sub <$> resize (div n 2) arbitrary <*> resize (div n 2) arbitrary
        , Mul <$> resize (div n 2) arbitrary <*> resize (div n 2) arbitrary
      ]










  -- Less headache for counter examples!
  shrink (Lit i) = [Lit i]
  shrink (Add e1 e2) = [e1, e2]
  shrink (Sub e1 e2) = [e1, e2]
  shrink (Mul e1 e2) = [e1, e2]