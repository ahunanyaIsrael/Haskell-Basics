module LibraryData where

import Data.List


data Book = Book { title :: String, author :: String, year :: Int, genre :: String, available :: Bool } deriving (Show, Eq)
data Library = Library { books :: [Book] } deriving (Show, Eq)

addBook:: Book -> Library -> Library
addBook b (Library bs) = Library (b:bs)

removeBook:: Book -> Library -> Library
removeBook b (Library bs) = Library (delete b bs)

showBooks:: Library -> String
showBooks (Library bs) = unlines (map show bs)



