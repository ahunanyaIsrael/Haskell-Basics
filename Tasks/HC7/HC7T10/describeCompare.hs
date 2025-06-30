-- Type class Describable (from previous task)
class Describable a where
    describe :: a -> String

-- Function with multiple constraints: Describable and Ord
describeAndCompare :: (Describable a, Ord a) => a -> a -> String
describeAndCompare x y =
    if x >= y then describe x else describe y


instance Describable Int where
    describe n = "Number " ++ show n

main :: IO ()
main = do
    print $ describeAndCompare (5 :: Int) (10 :: Int)
    print $ describeAndCompare (20 :: Int) (10 :: Int)


