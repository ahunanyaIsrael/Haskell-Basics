compareValues :: (Eq a, Ord a) => a -> a -> a
compareValues x y =
    if x >= y then x else y

main :: IO ()
main = do
    print (compareValues 3 7)       
    print (compareValues "apple" "banana") 
    print (compareValues 42 42)     
