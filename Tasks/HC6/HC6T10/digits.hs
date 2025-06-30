digits :: Int -> [Int]
digits n
  | n < 10    = [n]                                  
  | otherwise = digits (n `div` 10) ++ [n `mod` 10]  

main :: IO ()
main = do
  print (digits 1234)  
  print (digits 7)     

