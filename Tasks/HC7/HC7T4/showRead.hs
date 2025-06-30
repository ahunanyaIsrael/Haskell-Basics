
data Shape = Circle Double | Rectangle Double Double


instance Show Shape where
    show (Circle r) = "Circle " ++ show r
    show (Rectangle w h) = "Rectangle " ++ show w ++ " " ++ show h

instance Read Shape where
    readsPrec _ input =
        case words input of
            ("Circle" : rStr : rest) ->
                [(Circle (read rStr), unwords rest)]
            ("Rectangle" : wStr : hStr : rest) ->
                [(Rectangle (read wStr) (read hStr), unwords rest)]
            _ -> []

main :: IO ()
main = do
    let s1 = Circle 3.5
    let s2 = Rectangle 4.0 5.0

    print s1                       
    print s2                       

    let parsed1 = read "Circle 3.5" :: Shape
    let parsed2 = read "Rectangle 4.0 5.0" :: Shape

    print parsed1                 
    print parsed2                  
