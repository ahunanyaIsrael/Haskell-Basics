firstAndThird :: [a] -> Maybe (a, a)
firstAndThird (x:_:z:_) = Just (x, z)
firstAndThird _         = Nothing

main = do
  print $ firstAndThird [10, 20, 30, 40]  
  print $ firstAndThird [1, 2]            
