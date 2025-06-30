circleCircumference :: (Real a, Floating b) => a -> b
circleCircumference r = 2 * pi * (realToFrac r)


main :: IO ()
main = do
    print (circleCircumference 5 :: Double)   
    print (circleCircumference 7.5 :: Float)  
    print (circleCircumference (10 :: Integer) :: Double) 
