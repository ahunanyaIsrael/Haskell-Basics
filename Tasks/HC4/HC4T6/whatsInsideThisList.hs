whatsInsideThisList :: [a] -> String
whatsInsideThisList []       = "The list is empty."
whatsInsideThisList [x]      = "The list has one element."
whatsInsideThisList [x, y]   = "The list has two elements."
whatsInsideThisList (_:_:_:_) = "The list has three or more elements."

main = do
  print $ whatsInsideThisList ([] :: [Int])
  print $ whatsInsideThisList [1]
  print $ whatsInsideThisList [1,2]
  print $ whatsInsideThisList [1,2,3]
