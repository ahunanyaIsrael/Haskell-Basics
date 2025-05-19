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
    print (grade 50)  