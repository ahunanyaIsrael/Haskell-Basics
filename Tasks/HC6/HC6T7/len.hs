listLength :: [a] -> Int
listLength [] = 0                         
listLength (_:xs) = 1 + listLength xs 

main :: IO ()
main = do
  print (listLength [10, 20, 30])    
  print (listLength "hello")         
