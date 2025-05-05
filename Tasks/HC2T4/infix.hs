add :: Num a => a -> a -> a
add x y = x + y -- (+) x y 

myProduct :: Num a => a -> a -> a
myProduct x y = x * y --(*) x y 

myBoolean :: Bool -> Bool -> Bool
myBoolean x y = x && y -- (&&) x y 


main :: IO ()
main = do 
    print $ add 7 2
    print $ myProduct 5 6
    print $ myBoolean True False