concatStrings :: String -> String -> String
concatStrings str1 str2 = str1 ++ str2

main = do
   print $ concatStrings "Hello" "World"