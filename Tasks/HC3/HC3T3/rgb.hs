import Text.Printf (printf)

rgbToHex :: (Int, Int, Int) -> String
rgbToHex (r, g, b) = 
    let
        rHex = printf "%02X" r
        gHex = printf "%02X" g
        bHex = printf "%02X" b 
    in 
        rHex ++ gHex ++ bHex

main :: IO ()
main = do
  print $ rgbToHex (255, 0, 127)   
  print $ rgbToHex (0, 255, 64)    
