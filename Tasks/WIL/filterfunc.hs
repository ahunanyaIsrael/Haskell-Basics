{-The filter function in Haskell is used 
to select elements from a list that satisfy a given condition (predicate).-}

main :: IO ()
main = do
    print(filter even [1, 2, 3, 4, 5, 6])
    print(filter odd [1..5])
    print(filter (\x -> length x > 2) ["a", "abc"]) -- elements with length greater than 2