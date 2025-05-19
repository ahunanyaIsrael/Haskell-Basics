-- Define a function addNumbers that takes two integers and returns their sum
addNumbers :: Int -> Int -> Int
addNumbers x y = x + y

main :: IO ()
main = do 
    print (addNumbers 6 4)