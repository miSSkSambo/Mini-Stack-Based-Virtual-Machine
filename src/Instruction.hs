module Instruction where

type Value = Int
type VarName = String

data Instruction
  = PUSH Value
  | ADD
  | SUB
  | MUL
  | DIV
  | STORE VarName
  | LOAD VarName
  deriving (Show, Eq)
