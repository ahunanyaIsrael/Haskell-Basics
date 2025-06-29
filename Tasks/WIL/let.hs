-- in_range :: Int -> Int ->Int -> Int
-- in_range min max x =  x>= min && x <= max 
    
-- Using Let..In

-- Use: Defining local variables/expressions inside an expression (like inside a function or an if)
    -- let <bindings> in <expression>
-- squarePlusOne:: Int -> Int
-- squarePlusOne x = 
--     let 
--         square =  x * x
--     in 
--         square + 1

--     public int squarePlusOne(int x){
--         int square = x * x
--         return sqaure + 1
--     }

    -- Here:
-- let square = x * x creates a local variable
-- in square + 1 uses it

-- Use let ... in when you're inside an expression context (like in main, if, or a return).

in_range :: Ord a => a -> a -> a -> Bool
in_range min max x = 
    let
        in_lower_bounds = min <= x 
        in_upper_bounds = max >= x
    in
        in_lower_bounds && in_upper_bounds


--Using Where

-- Use: Also defines local variables/expressions, but goes after the main expression
-- Syntax
-- function args = expression
--   where
--     localBinding1 = ...
--     localBinding2 = ...

-- squarePlusOne x = square + 1
--   where
--   square = x * x


-- in_range :: Ord a => a -> a -> a -> Bool
-- in_range min max x = in_lower_bounds && in_upper_bounds
--     where
--     in_lower_bounds = min <= x 
--     in_upper_bounds = max >= x
    

-- in if

-- checkNumber :: Int -> String
-- checkNumber x = 
--   if let
--         doubled = x * 2 
--      in 
--         doubled > 10

--   then "Big number"
--   else "Small number"

-- with where
-- checkNumber :: Int -> String
-- checkNumber x =
--   if doubled > 10
--   then "Big number"
--   else "Small number"
--   where
--     doubled = x * 2

        
main :: IO ()
main = do
    print $ in_range 1 10 5 1 2 3 4 5 6 7 8 9 10
    -- print $ checkNumber 3 