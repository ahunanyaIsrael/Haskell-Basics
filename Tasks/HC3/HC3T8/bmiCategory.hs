bmiCategory :: Float -> Float -> String
bmiCategory weight height
    | bmi < 18.5  = "Underweight"
    | bmi < 25    = "Normal"
    | bmi < 30    = "Overweight"
    | otherwise   = "Obese"
  where
    bmi = weight / (height ^ 2)

main :: IO ()
main = do
    print (bmiCategory 70 1.75) 
    print (bmiCategory 90 1.8)   
