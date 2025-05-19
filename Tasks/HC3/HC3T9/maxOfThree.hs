maxOfThree :: Int -> Int -> Int -> Int
maxOfThree a b c =
  let
    maxAB = max a b
    maxABC = max maxAB c
  in
    maxABC

main :: IO ()
main = do
  print (maxOfThree 10 20 15) 
  print (maxOfThree 5 25 10)  
