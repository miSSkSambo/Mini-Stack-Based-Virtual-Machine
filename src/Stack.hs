module Stack where

type Stack = [Int]

push :: Int -> Stack -> Stack
push = (:)

pop :: Stack -> Either String (Int, Stack)
pop []     = Left "Stack underflow"
pop (x:xs) = Right (x, xs)
