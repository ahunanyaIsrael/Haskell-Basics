filterEvens :: [Int] -> [Int]
filterEvens [] = []                                   
filterEvens (x:xs)
  | even x    = x : filterEvens xs                      
  | otherwise = filterEvens xs                          


main :: IO ()
main = do
  print (filterEvens [1, 2, 3, 4, 5, 6])
