checkSquares :: [Int] -> Bool
checkSquares xs = any (>50) $ map (^2) $ filter (const True) xs

main :: IO ()
main = do
  print $ checkSquares [1..7]   
  print $ checkSquares [1..8]   
