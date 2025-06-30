myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []                             
myMap f (x:xs) = f x : myMap f xs           

main :: IO ()
main = do
  print (myMap (*2) [1, 2, 3, 4])     
  print (myMap length ["hi", "hello"]) 
