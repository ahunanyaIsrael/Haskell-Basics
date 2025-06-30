data Color = Green | Red | Blue

instance Ord Color where
    compare Red   Red   = EQ
    compare Red   _     = LT
    compare Green Red   = GT
    compare Green Green = EQ
    compare Green Blue  = LT
    compare Blue  Blue  = EQ
    compare Blue  _     = GT

main :: IO ()
main = do
    print (Red < Green)    -- True
    print (Green < Blue)   -- True
    print (Red < Blue)     -- True
    print (Blue < Red)     -- False
    print (compare Red Blue)  -- LT

