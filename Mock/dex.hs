{-# LANGUAGE RecordWildCards #-}

module Main where

import qualified Data.Map as M
import Data.Map (Map)
import Prelude

type User = String

data Token = TokenA | TokenB | LPToken deriving (Eq, Ord, Show)

data DEXState = DEXState
  { reservesA :: Integer
  , reservesB :: Integer
  , lpSupply :: Integer
  , userBalances :: M.Map User (M.Map Token Integer)
  } deriving (Show)

initialState :: DEXState
initialState = DEXState 0 0 0 M.empty

getUserBalance :: User -> Token -> DEXState -> Integer
getUserBalance user token state =
  case M.lookup user (userBalances state) of
    Just tokens -> M.findWithDefault 0 token tokens
    Nothing -> 0

adjustUserBalance :: User -> Token -> Integer -> DEXState -> DEXState
adjustUserBalance user token delta state =
  let current = getUserBalance user token state
      newAmount = current + delta
      userBalances' = M.alter (\mb -> 
        let tokens = case mb of
                      Just t -> t
                      Nothing -> M.empty
            currentToken = M.findWithDefault 0 token tokens
            newToken = currentToken + delta
            in if newToken < 0
               then error "Insufficient balance"
               else Just (M.insert token newToken tokens)
        ) user (userBalances state)
  in state { userBalances = userBalances' }

swapAForB :: User -> Integer -> DEXState -> DEXState
swapAForB user amountA state@DEXState{..}
  | userBalanceA < amountA = error "Insufficient TokenA balance"
  | reservesA == 0 || reservesB == 0 = error "Insufficient liquidity"
  | amountB <= 0 = error "Invalid swap amount"
  | otherwise = state'
  where
    userBalanceA = getUserBalance user TokenA state
    amountB = (amountA * reservesB) `div` (reservesA + amountA)
    newReservesA = reservesA + amountA
    newReservesB = reservesB - amountB
    state' = adjustUserBalance user TokenB amountB 
           $ adjustUserBalance user TokenA (-amountA) 
           $ state { reservesA = newReservesA, reservesB = newReservesB }

swapBForA :: User -> Integer -> DEXState -> DEXState
swapBForA user amountB state@DEXState{..}
  | userBalanceB < amountB = error "Insufficient TokenB balance"
  | reservesA == 0 || reservesB == 0 = error "Insufficient liquidity"
  | amountA <= 0 = error "Invalid swap amount"
  | otherwise = state'
  where
    userBalanceB = getUserBalance user TokenB state
    amountA = (amountB * reservesA) `div` (reservesB + amountB)
    newReservesB = reservesB + amountB
    newReservesA = reservesA - amountA
    state' = adjustUserBalance user TokenA amountA 
           $ adjustUserBalance user TokenB (-amountB) 
           $ state { reservesA = newReservesA, reservesB = newReservesB }

addLiquidity :: User -> Integer -> Integer -> DEXState -> DEXState
addLiquidity user amountA amountB state@DEXState{..}
  | userBalanceA < amountA || userBalanceB < amountB = 
      error "Insufficient TokenA or TokenB balance"
  | reservesA == 0 && reservesB == 0 = 
      let lpMinted = floor (sqrt (fromIntegral (amountA * amountB) :: Double))
      in initLiquidity amountA amountB lpMinted
  | amountA * reservesB /= amountB * reservesA = 
      error "Invalid ratio for liquidity"
  | otherwise = addExistingLiquidity amountA amountB
  where
    userBalanceA = getUserBalance user TokenA state
    userBalanceB = getUserBalance user TokenB state
    
    initLiquidity a b lp = 
      adjustUserBalance user LPToken lp
      $ adjustUserBalance user TokenB (-b)
      $ adjustUserBalance user TokenA (-a)
      $ state { reservesA = a, reservesB = b, lpSupply = lp }
    
    addExistingLiquidity a b =
      let lpMinted = (a * lpSupply) `div` reservesA
      in adjustUserBalance user LPToken lpMinted
         $ adjustUserBalance user TokenB (-b)
         $ adjustUserBalance user TokenA (-a)
         $ state { reservesA = reservesA + a
                 , reservesB = reservesB + b
                 , lpSupply = lpSupply + lpMinted }

removeLiquidity :: User -> Integer -> DEXState -> DEXState
removeLiquidity user amountLP state@DEXState{..}
  | userLPBalance < amountLP || amountLP <= 0 = 
      error "Insufficient LP tokens or invalid amount"
  | lpSupply == 0 = error "No liquidity to remove"
  | otherwise = finalState
  where
    userLPBalance = getUserBalance user LPToken state
    withdrawA = (amountLP * reservesA) `div` lpSupply
    withdrawB = (amountLP * reservesB) `div` lpSupply
    newReservesA = reservesA - withdrawA
    newReservesB = reservesB - withdrawB
    newLpSupply = lpSupply - amountLP
    
    finalState = adjustUserBalance user TokenB withdrawB 
               $ adjustUserBalance user TokenA withdrawA 
               $ adjustUserBalance user LPToken (-amountLP) 
               $ state { reservesA = newReservesA
                       , reservesB = newReservesB
                       , lpSupply = newLpSupply }


main :: IO ()
main = do
  let dex = initialState
      -- Fund initial users
      funded = foldr (uncurry3 adjustUserBalance) dex
        [ ("Alice", TokenA, 1000), ("Alice", TokenB, 1000)
        , ("Bob", TokenA, 1000), ("Bob", TokenB, 1000) ]
      
      -- Add initial liquidity
      afterInitialLiquidity = addLiquidity "Alice" 100 200 funded
      
      -- Perform a swap
      afterSwap = swapAForB "Bob" 10 afterInitialLiquidity
      
      -- Add more liquidity
      afterMoreLiquidity = addLiquidity "Bob" 10 20 afterSwap
      
      -- Remove liquidity
      finalState = removeLiquidity "Alice" 50 afterMoreLiquidity

  putStrLn "Initial DEX state:"
  print dex
  
  putStrLn "\nAfter funding users:"
  print funded
  
  putStrLn "\nAfter initial liquidity addition:"
  print afterInitialLiquidity
  
  putStrLn "\nAfter Bob's swap:"
  print afterSwap
  
  putStrLn "\nAfter Bob adds more liquidity:"
  print afterMoreLiquidity
  
  putStrLn "\nFinal state after Alice removes liquidity:"
  print finalState

-- Helper functions for main
uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c