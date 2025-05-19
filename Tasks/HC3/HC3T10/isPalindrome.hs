isPalindrome :: String -> Bool
isPalindrome str
    | length str <= 1                 = True
    | head str == last str           = isPalindrome (init (tail str))
    | otherwise                      = False

main :: IO ()
main = do
    print (isPalindrome "racecar")   
    print (isPalindrome "haskell")  
    print (isPalindrome "madam")     
