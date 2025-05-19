addFive :: Num a => a -> a
addFive = (+5)

main :: IO ()
main = print $ addFive 10  
