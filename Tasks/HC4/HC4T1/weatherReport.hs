--- Functional that the function as to follow
weatherReport :: String -> String
weatherReport "sunny"  = "It's a bright and beautiful day!"
weatherReport "rainy"  = "Don't forget your umbrella!"
weatherReport "cloudy" = "A bit gloomy, but no rain yet!"
weatherReport _        = "Weather unknown"


-- Substitute for if..else
comparAB :: String -> String
comparAB a 
    | a == "sunny" = "It's a bright and beautiful day!"
    | a ==  "rainy" = "Don't forget your umbrella!"
    | a == "cloudy" = "A bit gloomy, but no rain yet!"
    | otherwise = "Weather unknown"


main :: IO ()
main = do
    print (weatherReport "sunny")    
    print (comparAB "sunny")    
    -- print (weatherReport "rainy")    
    -- print (weatherReport "cloudy")   
    -- print (weatherReport "windy")    
