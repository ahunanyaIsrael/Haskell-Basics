biggerThan10 :: Int -> Bool
biggerThan10 = \x -> x > 10

main :: IO ()
main = print $ biggerThan10 15 
