import Data.Time.Clock (UTCTime, getCurrentTime)
import Data.Char (ord)
import Data.List (intercalate)
{-
1. Define the Block data type with index, timestamp, data, previous hash, and current hash.

2. Create a function to generate the hash of a block.

3. Create a genesis block (the first block in the chain).

4. Define functions to add a new block to the chain, which requires computing the new block's hash based on the previous block and the new data.

5. Implement validation of the blockchain to ensure all hashes are correct and the previous hashes match.


-}

data Block = Block {
    index :: Int,
    timestamp :: UTCTime,
    blockData :: String,  -- Changed from 'data' which is a reserved keyword
    previousHash :: String,
    currentHash :: String
} deriving (Show)

generateHash :: Int -> UTCTime -> String -> String -> String
generateHash index timestamp blockData previousHash = show $ hash $ (index, timestamp, blockData, previousHash) -- or show (index + length data + length previousHash)

-- Create genesis block (first block in the chain)
createGenesisBlock :: IO Block
createGenesisBlock = do
    currentTime <- getCurrentTime
    let genesisHash = generateHash 0 currentTime "Genesis Block" "0"
    return $ Block {
        index = 0,
        timestamp = currentTime,
        blockData = "Genesis Block",
        previousHash = "0",
        currentHash = genesisHash
    }

-- Add a new block to the chain
addBlock :: Block -> String -> IO Block
addBlock previousBlock newData = do
    currentTime <- getCurrentTime
    let newIndex = index previousBlock + 1
        newPrevHash = currentHash previousBlock
        newHash = generateHash newIndex currentTime newData newPrevHash
        newBlock = Block {
            index = newIndex,
            timestamp = currentTime,
            blockData = newData,
            previousHash = newPrevHash,
            currentHash = newHash
        }
    return newBlock

-- Validate the entire blockchain
validateBlockChain :: [Block] -> Bool
validateBlockChain [] = True
validateBlockChain [block] = 
    currentHash block == generateHash (index block) (timestamp block) (blockData block) (previousHash block)
validateBlockChain (current:next:rest) =
    let currentValid = currentHash current == generateHash (index current) (timestamp current) (blockData current) (previousHash current)
        linkValid = previousHash next == currentHash current
    in currentValid && linkValid && validateBlockChain (next:rest)


main :: IO ()
main = do
    genesis <- createGenesisBlock
    putStrLn "Genesis Block:"
    print genesis
    
    block1 <- addBlock genesis "First transaction"
    putStrLn "\nBlock 1:"
    print block1
    
    block2 <- addBlock block1 "Second transaction"
    putStrLn "\nBlock 2:"
    print block2
    
    let chain = [genesis, block1, block2]
    putStrLn $ "\nBlockchain valid: " ++ show (validateBlockChain chain)
    
    -- Test with invalid chain
    let invalidBlock = block2 { currentHash = "tampered" }
    let invalidChain = [genesis, block1, invalidBlock]
    putStrLn $ "\nInvalid blockchain valid: " ++ show (validateBlockChain invalidChain)