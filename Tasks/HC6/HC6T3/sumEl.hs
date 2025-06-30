sumList :: [Int] -> Int
sumList = foldr (+) 0

main :: IO ()
main = print (sumList [1, 2, 3, 4])  
