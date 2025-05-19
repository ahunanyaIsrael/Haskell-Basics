gradeComment :: Int -> String
gradeComment grade
  | grade >= 90 && grade <= 100 = "Excellent!"
  | grade >= 70 && grade <= 89  = "Good job!"
  | grade >= 50 && grade <= 69  = "You passed."
  | grade >= 0  && grade <= 49  = "Better luck next time."
  | otherwise                   = "Invalid grade"

main :: IO ()
main = do
  print $ gradeComment 95  
  print $ gradeComment 75 
  print $ gradeComment 55  
  print $ gradeComment 30  
  print $ gradeComment 110 
