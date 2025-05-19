isLeapYear :: Int -> Bool
isLeapYear year =
  if year `mod` 400 == 0 then True
  else if year `mod` 100 == 0 then False
  else if year `mod` 4 == 0 then True
  else False

main :: IO ()
main = do
  print (isLeapYear 2000)  -- True (divisible by 400)
  print (isLeapYear 1900)  -- False (divisible by 100 but not 400)
  print (isLeapYear 2024)  -- True (divisible by 4)
