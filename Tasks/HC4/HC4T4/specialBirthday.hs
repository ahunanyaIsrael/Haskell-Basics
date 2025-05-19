specialBirthday :: Int -> String
specialBirthday 1  = "Happy 1st birthday!"
specialBirthday 16 = "Sweet sixteen!"
specialBirthday 21 = "Welcome to adulthood!"
specialBirthday _  = "Have a great birthday!"

main :: IO ()
main = do
  print $ specialBirthday 1
  print $ specialBirthday 16
  print $ specialBirthday 21
  print $ specialBirthday 10
