circleArea :: Float -> Float
circleArea radius = pi * radius * radius

main :: IO()
main = print(circleArea 5)

HC1T3
greaterThan18 :: Int -> Bool
greaterThan18 x = x > 18

main :: IO()
main = print(greaterThan18 20)