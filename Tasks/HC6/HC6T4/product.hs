sumList :: [Int] -> Int
sumList = foldl (*) 1

main :: IO ()
main = print (sumList [1, 2, 3, 4])  
