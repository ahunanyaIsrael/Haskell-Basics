{-
This function compares your time to an average time and tells you:

If you're faster than average

If you're slower than average

Or if your time is exactly average

It also tells you how many seconds you were faster or slower
-}

trackScore4 :: Float -> Float -> String
trackScore4 time avgTime
    | time < avgTime = "Great! Your time is " ++ show (score) ++ "seconds below average!"
    | time > avgTime = "Your time is " ++ show (score) ++ " seconds above average."
    | otherwise = "Your time is on par with the average time!"
    where
      score = (\x y -> abs (x - y)) time avgTime

main :: IO ()
main = do 
    -- print ((\x -> x ^ 2) 7)
    -- print ((\ x -> x * 4) 3)
    print ((\x y -> x * y) 3 7)
    print $ filter (\ x -> x `mod` 2 == 0) [1,2,3,4,5,6]
    print $ map (\ x -> x * 2) [1,2,3,4,5,6]
    

    -- print $ trackScore4 5 6