{-
The map function in Haskell applies a function to every element of a list, returning a new list with the results.

-}


main :: IO ()
main = do
    print(map (*2) [1,2,3,4,5] )
    print(map not [True, False] )
    print (map reverse ["Cardano", "ADA"] ) -- strings are a list of characters