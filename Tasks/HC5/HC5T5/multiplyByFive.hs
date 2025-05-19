multiplyByFive :: Num a => a -> a
multiplyByFive = (*5)

main :: IO ()
main = print $ multiplyByFive 7 
