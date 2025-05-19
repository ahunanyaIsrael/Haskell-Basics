transformList :: (a -> a) -> [a] -> [a]
transformList f = map (f . f)

main :: IO ()
main = print $ transformList (+1) [1,2,3]
