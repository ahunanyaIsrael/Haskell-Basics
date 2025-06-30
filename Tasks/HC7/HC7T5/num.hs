
squareArea :: Num a => a -> a
squareArea side = side * side

main :: IO ()
main = do
    print (squareArea 4)      
    print (squareArea 4.5)    
