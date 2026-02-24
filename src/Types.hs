module Types where

import qualified Data.Map as Map
import Instruction
import Stack

type Memory = Map.Map String Int

data VMState = VMState
  { stack  :: Stack
  , memory :: Memory
  } deriving Show

emptyState :: VMState
emptyState = VMState [] Map.empty
