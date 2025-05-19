applyThrice :: (Int -> Int) -> Int -> Int
applyThrice f x = f (f (f x))

main :: IO ()
main = print $ applyThrice (+2) 5 
