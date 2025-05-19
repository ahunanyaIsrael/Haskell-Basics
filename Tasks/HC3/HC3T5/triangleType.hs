triangleType :: Float -> Float -> Float -> String
triangleType a b c
    | a == b && b == c           = "Equilateral"
    | a == b || b == c || a == c = "Isosceles"
    | otherwise                  = "Scalene"

main :: IO ()
main = do 
    print (triangleType 3 3 3)   
    print (triangleType 5 5 8)   
    print (triangleType 6 7 8)   
