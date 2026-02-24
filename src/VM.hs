module VM where

import qualified Data.Map as Map
import Instruction
import Stack
import Types

execute :: VMState -> [Instruction] -> Either String VMState
execute state [] = Right state

execute state (instr:rest) =
  case instr of

    PUSH n ->
      execute state{ stack = push n (stack state) } rest

    ADD ->
      binaryOp state rest (+)

    SUB ->
      binaryOp state rest (-)

    MUL ->
      binaryOp state rest (*)

    DIV ->
      binaryOp state rest div

    STORE name ->
      case pop (stack state) of
        Left err -> Left err
        Right (val, newStack) ->
          let newMem = Map.insert name val (memory state)
          in execute state{ stack = newStack, memory = newMem } rest

    LOAD name ->
      case Map.lookup name (memory state) of
        Nothing -> Left "Variable not found"
        Just val ->
          execute state{ stack = push val (stack state) } rest


binaryOp :: VMState -> [Instruction] -> (Int -> Int -> Int) -> Either String VMState
binaryOp state rest op =
  case pop (stack state) of
    Left err -> Left err
    Right (x, stack1) ->
      case pop stack1 of
        Left err -> Left err
        Right (y, stack2) ->
          let result = op y x
          in execute state{ stack = push result stack2 } rest
