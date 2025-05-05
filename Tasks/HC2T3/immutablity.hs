myAge :: Int
myAge = 25

piValue :: Double
piValue = 3.14159

greeting :: String
greeting = "Hello, Haskell!"

isHaskellFun :: Bool
isHaskellFun = True

myAge = 30
piValue = 34
greeting = "Hi, Haskell!"
isHaskellFun = False

main :: IO ()
main = do
  putStrLn ("My age is: " ++ show myAge)
  putStrLn ("The value of pi is: " ++ show piValue)
  putStrLn ("Greeting: " ++ greeting)
  putStrLn ("Is Haskell fun? " ++ show isHaskellFun)