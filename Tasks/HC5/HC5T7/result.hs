result :: Int
result = sum $ map (*2) $ filter (>3) [1..10]

main :: IO ()
main = print result  