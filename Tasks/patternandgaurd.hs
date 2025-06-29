-- In Haskell, guards are a way to choose between different possible values or functions based on boolean conditions. 
-- They work similarly to if...else if...else chains in other languages but are more elegant and readable in functional code.

-- functionName args 
--   | condition1 = result1
--   | condition2 = result2
--   | otherwise  = defaultResult
-- Each guard starts with a | followed by a boolean expression (condition).

-- otherwise is a built-in synonym for True, used as a default case.


comparAB :: Int -> Int -> String
comparAB a b 
    | a == b = "Equals"
    | a > b  = "A GREATER THAN B"
    | otherwise = "B GREATER THAN A"


grade :: Int -> String
grade mark 
    | mark >= 90 = "A"
    | mark >= 80 = "B"
    | mark >= 70 = "C"
    | mark >= 60 = "D"
    | otherwise  = "F"


{-
Pattern Matching in Haskell is a powerful feature that lets you check a 
value against a pattern and deconstruct 
data directly in function definitions, case expressions, or let bindings.

-}

sayHello :: String -> String
sayHello "Alice" = "Hello Alice!"
sayHello "Bob"   = "Hi Bob!"
sayHello _       = "Hey there!"  -- the underscore is a wildcard


--- Rule that the function as to follow
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
    print (grade 95)  
    print (grade 72)  
    print $ sayHello "Alice"
    print (weatherReport "sunny")    
    print (comparAB "sunny")
    -- print (comparAB 50 7)  