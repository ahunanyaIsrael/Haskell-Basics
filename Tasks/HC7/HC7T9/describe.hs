
data Shape = Circle Double | Rectangle Double Double
  deriving (Show)

class Describable a where
    describe :: a -> String

instance Describable Bool where
    describe True  = "This is True"
    describe False = "This is False"

instance Describable Shape where
    describe (Circle r)      = "A circle with radius " ++ show r
    describe (Rectangle w h) = "A rectangle with width " ++ show w ++ " and height " ++ show h


main :: IO ()
main = do
    print $ describe True
    print $ describe False
    print $ describe (Circle 5)
    print $ describe (Rectangle 3 4)
