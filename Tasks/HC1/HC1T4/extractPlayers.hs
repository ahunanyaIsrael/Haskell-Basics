extractPlayers :: ((String, Int)) -> String
extractPlayers (name, _) = name

main :: IO ()
main = do
    let players = [("John", 10), ("Alice", 20)]
    let player = extractPlayers (head players)
    
    