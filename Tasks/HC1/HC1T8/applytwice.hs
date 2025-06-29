applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

double :: Num a => a -> a
double num = num * 2

main:: IO ()
main = print $ applyTwice double 7 