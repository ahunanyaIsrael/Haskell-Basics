evenSquares :: [Int] -> [Int]
evenSquares = filter even . map (^2)

main = print $ evenSquares [1..10]


