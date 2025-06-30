data Color = Green | Red | Blue

instance Eq Color where
    Red   == Red   = True
    Green == Green = True
    Blue  == Blue  = True
    _     == _     = False

main :: IO ()
main = do
    print (Red == Red)    
    print (Red == Blue)  
    print (Green == Green)
