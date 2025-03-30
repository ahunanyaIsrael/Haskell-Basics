-- module Main where

-- import Data.Char (isSpace, isDigit)

-- -- Lexer
-- data Token = TInt Int | TPlus | TMinus | TMul | TDiv | TParenL | TParenR
--     deriving (Show)

-- lexer :: String -> [Token]
-- lexer [] = []
-- lexer (c:cs)
--     | isSpace c = lexer cs
--     | isDigit c = let (num, rest) = span isDigit (c:cs)
--                   in TInt (read num) : lexer rest
--     | c == '+'  = TPlus : lexer cs
--     | c == '-'  = TMinus : lexer cs
--     | c == '*'  = TMul : lexer cs
--     | c == '/'  = TDiv : lexer cs
--     | c == '('  = TParenL : lexer cs
--     | c == ')'  = TParenR : lexer cs
--     | otherwise = error $ "Unexpected character: " ++ [c]

-- -- Parser
-- data Expr = Lit Int 
--           | Add Expr Expr 
--           | Sub Expr Expr 
--           | Mul Expr Expr 
--           | Div Expr Expr
--     deriving (Show)

-- parseExpr :: [Token] -> (Expr, [Token])
-- parseExpr tokens = 
--     let (term, tokens') = parseTerm tokens
--     in parseExpr' term tokens'
--     where
--         parseExpr' left (TPlus : rest) =
--             let (right, rest') = parseTerm rest
--             in parseExpr' (Add left right) rest'
--         parseExpr' left (TMinus : rest) =
--             let (right, rest') = parseTerm rest
--             in parseExpr' (Sub left right) rest'
--         parseExpr' left rest = (left, rest)

-- parseTerm :: [Token] -> (Expr, [Token])
-- parseTerm tokens = 
--     let (factor, tokens') = parseFactor tokens
--     in parseTerm' factor tokens'
--     where
--         parseTerm' left (TMul : rest) =
--             let (right, rest') = parseFactor rest
--             in parseTerm' (Mul left right) rest'
--         parseTerm' left (TDiv : rest) =
--             let (right, rest') = parseFactor rest
--             in parseTerm' (Div left right) rest'
--         parseTerm' left rest = (left, rest)

-- parseFactor :: [Token] -> (Expr, [Token])
-- parseFactor (TInt n : rest) = (Lit n, rest)
-- parseFactor (TParenL : rest) = 
--     case parseExpr rest of
--         (e, TParenR : rest') -> (e, rest')
--         _ -> error "Missing closing parenthesis"
-- parseFactor tokens = error $ "Unexpected tokens in factor: " ++ show tokens

-- -- Code Generator
-- data Instruction = Push Int | AddOp | SubOp | MulOp | DivOp
--     deriving (Show)

-- compile :: Expr -> [Instruction]
-- compile (Lit n) = [Push n]
-- compile (Add e1 e2) = compile e1 ++ compile e2 ++ [AddOp]
-- compile (Sub e1 e2) = compile e1 ++ compile e2 ++ [SubOp]
-- compile (Mul e1 e2) = compile e1 ++ compile e2 ++ [MulOp]
-- compile (Div e1 e2) = compile e1 ++ compile e2 ++ [DivOp]

-- -- Compiler Pipeline
-- compiler :: String -> [Instruction]
-- compiler input = 
--     let tokens = lexer input
--         (expr, rest) = parseExpr tokens
--     in if null rest 
--         then compile expr 
--         else error "Unexpected tokens after expression"

-- -- Main
-- main :: IO ()
-- main = do
--     putStrLn "Enter arithmetic expression:"
--     input <- getLine
--     putStrLn "Generated instructions:"
--     print (compiler input)

module Main where

import Data.Char (isSpace, isDigit)

-- Lexer (same as before)
data Token = TInt Int | TPlus | TMinus | TMul | TDiv | TParenL | TParenR
    deriving (Show)

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs)
    | isSpace c = lexer cs
    | isDigit c = let (num, rest) = span isDigit (c:cs)
                  in TInt (read num) : lexer rest
    | c == '+'  = TPlus : lexer cs
    | c == '-'  = TMinus : lexer cs
    | c == '*'  = TMul : lexer cs
    | c == '/'  = TDiv : lexer cs
    | c == '('  = TParenL : lexer cs
    | c == ')'  = TParenR : lexer cs
    | otherwise = error $ "Unexpected character: " ++ [c]

-- Parser (same as before)
data Expr = Lit Int 
          | Add Expr Expr 
          | Sub Expr Expr 
          | Mul Expr Expr 
          | Div Expr Expr
    deriving (Show)

parseExpr :: [Token] -> (Expr, [Token])
parseExpr tokens = 
    let (term, tokens') = parseTerm tokens
    in parseExpr' term tokens'
    where
        parseExpr' left (TPlus : rest) =
            let (right, rest') = parseTerm rest
            in parseExpr' (Add left right) rest'
        parseExpr' left (TMinus : rest) =
            let (right, rest') = parseTerm rest
            in parseExpr' (Sub left right) rest'
        parseExpr' left rest = (left, rest)

parseTerm :: [Token] -> (Expr, [Token])
parseTerm tokens = 
    let (factor, tokens') = parseFactor tokens
    in parseTerm' factor tokens'
    where
        parseTerm' left (TMul : rest) =
            let (right, rest') = parseFactor rest
            in parseTerm' (Mul left right) rest'
        parseTerm' left (TDiv : rest) =
            let (right, rest') = parseFactor rest
            in parseTerm' (Div left right) rest'
        parseTerm' left rest = (left, rest)

parseFactor :: [Token] -> (Expr, [Token])
parseFactor (TInt n : rest) = (Lit n, rest)
parseFactor (TParenL : rest) = 
    case parseExpr rest of
        (e, TParenR : rest') -> (e, rest')
        _ -> error "Missing closing parenthesis"
parseFactor tokens = error $ "Unexpected tokens in factor: " ++ show tokens

-- Code Generator (same as before)
data Instruction = Push Int | AddOp | SubOp | MulOp | DivOp
    deriving (Show)

compile :: Expr -> [Instruction]
compile (Lit n) = [Push n]
compile (Add e1 e2) = compile e1 ++ compile e2 ++ [AddOp]
compile (Sub e1 e2) = compile e1 ++ compile e2 ++ [SubOp]
compile (Mul e1 e2) = compile e1 ++ compile e2 ++ [MulOp]
compile (Div e1 e2) = compile e1 ++ compile e2 ++ [DivOp]

-- New Evaluator
evaluate :: [Instruction] -> Int
evaluate = go []
  where
    go stack [] = case stack of
      [result] -> result
      _        -> error "Invalid stack state at end of evaluation"
    go stack (Push n : ins) = go (n : stack) ins
    go stack (AddOp : ins) = case stack of
      (x:y:rest) -> go (y + x : rest) ins
      _ -> error "Stack underflow for addition"
    go stack (SubOp : ins) = case stack of
      (x:y:rest) -> go (y - x : rest) ins
      _ -> error "Stack underflow for subtraction"
    go stack (MulOp : ins) = case stack of
      (x:y:rest) -> go (y * x : rest) ins
      _ -> error "Stack underflow for multiplication"
    go stack (DivOp : ins) = case stack of
      (0:_) -> error "Division by zero"
      (x:y:rest) -> go (y `div` x : rest) ins
      _ -> error "Stack underflow for division"

-- Updated Compiler Pipeline
compiler :: String -> ([Instruction], Int)
compiler input = 
    let tokens = lexer input
        (expr, rest) = parseExpr tokens
    in if null rest 
        then let instr = compile expr 
             in (instr, evaluate instr)
        else error "Unexpected tokens after expression"

-- Updated Main
main :: IO ()
main = do
    putStrLn "Enter arithmetic expression:"
    input <- getLine
    case compiler input of
        (instructions, result) -> do
            putStrLn "Generated instructions:"
            print instructions
            putStrLn "Computed result:"
            print result