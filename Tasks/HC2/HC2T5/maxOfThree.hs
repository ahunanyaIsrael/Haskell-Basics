maxOfThree :: Int -> Int -> Int -> Int
maxOfThree x y z = max x (max y z) -- get the max of y x then compare x and the give answer 

main :: IO ()
main = do
    print $ maxOfThree 5 6 7