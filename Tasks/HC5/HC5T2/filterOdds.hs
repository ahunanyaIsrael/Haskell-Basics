filterOdds :: [Int]
filterOdds = filter odd [1..30]

main :: IO ()
main = print filterOdds  
