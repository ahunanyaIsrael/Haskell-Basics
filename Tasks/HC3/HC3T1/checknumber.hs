checkNumber :: Int -> String
checkNumber x = do
    if x > 0 then "Positive"
    else if x < 0 then "Negative"
    else "Zero"

main  :: IO ()
main = do
    print (checkNumber 5)   
    print (checkNumber (-3))  
    print (checkNumber 0)
