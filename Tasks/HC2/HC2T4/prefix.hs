add :: Num a => a -> a -> a
add x y = (+) x y -- 5 + 3

myProduct :: Num a => a -> a -> a
myProduct x y = (*) x y -- 10 * 4

myBoolean :: Bool -> Bool -> Bool
myBoolean x y = (&&) x y -- True && False


main :: IO ()
main = do 
    print $ add 5 3
    print $ myProduct 10 4
    print $ myBoolean True False