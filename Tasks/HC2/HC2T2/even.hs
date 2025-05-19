evenNum :: Int -> Bool
evenNum x = x `mod` 2 == 0

main :: IO ()
main = do
    print $ evenNum 5  
    print $ evenNum 4
    print $ evenNum 3
    print $ evenNum 2
    print $ evenNum 1