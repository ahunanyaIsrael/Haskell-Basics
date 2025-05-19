season :: Int -> String
season month
    | month == 12 || month == 1 || month == 2   = "Winter"
    | month == 3  || month == 4 || month == 5   = "Spring"
    | month == 6  || month == 7 || month == 8   = "Summer"
    | month == 9  || month == 10 || month == 11 = "Autumn"
    | otherwise                                 = "Invalid month"

main :: IO ()
main = do
    print (season 1)   
    print (season 4)    
    print (season 7)
