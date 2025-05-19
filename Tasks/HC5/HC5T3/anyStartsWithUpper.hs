import Data.Char (isUpper)

anyStartsWithUpper :: [String] -> Bool
anyStartsWithUpper = any (\w -> not (null w) && isUpper (head w))

main :: IO ()
main = print $ anyStartsWithUpper ["hello", "World", "test"]
