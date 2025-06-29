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
    
main :: IO ()
main = do
    print (grade 95)  
    print (grade 72)  
    -- print (comparAB 50 7)  