module Main where

import VM
import Instruction
import Types

main :: IO ()
main = do
  putStrLn "⚡ Mini EVM Haskell"

  let program =
        [ PUSH 10
        , PUSH 20
        , ADD
        , STORE "result"
        , LOAD "result"
        , PUSH 2
        , MUL
        ]

  case execute emptyState program of
    Left err -> putStrLn ("Error: " ++ err)
    Right finalState -> do
      putStrLn "Final VM State:"
      print finalState
