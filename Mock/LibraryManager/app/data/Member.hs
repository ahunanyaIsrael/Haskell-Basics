module MemberData where

import Data.List

data Member = Member{
    name : String,
    id : String,
    borrowedBooks : [String]
}
