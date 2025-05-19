describeTuple :: (Show a, Show b, Show c) => (a, b, c) -> String
describeTuple (x, y, z) = "Tuple contains: " ++ show x ++ ", " ++ show y ++ ", and " ++ show z

main = do
  print $ describeTuple (1, "hello", 3.14)
