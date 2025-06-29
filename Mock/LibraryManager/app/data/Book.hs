module BookData where 

data Book = Book {
    title :: String,
    author :: String,
    isbn :: String,
    isBorrowed :: Bool
} deriving (Show, Eq)