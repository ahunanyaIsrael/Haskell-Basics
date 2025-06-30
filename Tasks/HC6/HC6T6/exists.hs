elementExists :: Eq a => a -> [a] -> Bool
elementExists _ [] = False                           
elementExists x (y:ys)
  | x == y    = True                                  
  | otherwise = elementExists x ys                    

main :: IO ()
main = do
  print (elementExists 3 [1, 2, 3, 4])  
  print (elementExists 5 [1, 2, 3, 4])  
