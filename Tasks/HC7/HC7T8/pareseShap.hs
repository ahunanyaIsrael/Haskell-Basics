import Text.Read (readMaybe)

data Shape = Circle Double | Rectangle Double Double
  deriving (Show, Read)

parseShape :: String -> Maybe Shape
parseShape str = readMaybe str


main :: IO ()
main = do
  print $ parseShape "Circle 3.5"          
  print $ parseShape "Rectangle 4.0 5.0"   
  print $ parseShape "Triangle 3 4 5"      
  print $ parseShape "Circle abc"          
