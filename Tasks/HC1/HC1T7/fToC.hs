fToC :: Float -> Float
fToC f = (f - 32) * 5/9

main :: IO ()
main = print(fToC 32)
