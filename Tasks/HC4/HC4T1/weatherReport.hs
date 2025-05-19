weatherReport :: String -> String
weatherReport "sunny"  = "It's a bright and beautiful day!"
weatherReport "rainy"  = "Don't forget your umbrella!"
weatherReport "cloudy" = "A bit gloomy, but no rain yet!"
weatherReport _        = "Weather unknown"

main :: IO ()
main = do
    print (weatherReport "sunny")    
    print (weatherReport "rainy")    
    print (weatherReport "cloudy")   
    print (weatherReport "windy")    
