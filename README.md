# ⚡ Mini EVM Haskell

![Haskell](https://img.shields.io/badge/Language-Haskell-purple)
![Build](https://img.shields.io/badge/Build-Cabal-blue)
![Architecture](https://img.shields.io/badge/Architecture-Stack--Based-green)
![Runtime](https://img.shields.io/badge/Execution-Deterministic-orange)
![Status](https://img.shields.io/badge/Project-Active-success)
![License](https://img.shields.io/badge/License-MIT-brightgreen)

A simplified Ethereum-style stack-based virtual machine written entirely in Haskell.

This project models how smart contract bytecode executes at a low level using a deterministic stack runtime and immutable state transitions.

---

# 📑 Table of Contents

- [📖 Project Overview](#-project-overview)
- [🎯 Goals of This Project](#-goals-of-this-project)
- [🏗️ System Architecture](#️-system-architecture)
- [🧠 Instruction Set](#-instruction-set)
- [⚙️ Execution Engine](#️-execution-engine)
- [🧪 Example Program Walkthrough](#-example-program-walkthrough)
- [🔨 Build & Run](#-build--run)
- [📸 Screenshots](#-screenshots)
- [🧠 Concepts Demonstrated](#-concepts-demonstrated)
- [💡 Why I Built This](#-why-i-built-this)
- [🚀 Future Improvements](#-future-improvements)
- [👤 Author](#-author)
- [📜 License](#-license)

---

# 📖 Project Overview

The Mini EVM Haskell project implements a minimal stack-based virtual machine inspired by the Ethereum Virtual Machine (EVM).

It demonstrates how smart contracts are executed at the bytecode level using:

- A stack-based execution model
- Deterministic instruction processing
- Immutable state transitions
- Functional runtime architecture
- Memory storage and retrieval
- Error-safe execution using `Either`

This project is designed to simulate the core execution layer of a blockchain system.

---

# 🎯 Goals of This Project

This project was built to:

- Understand execution-layer blockchain architecture
- Design a bytecode instruction system
- Implement a stack machine from first principles
- Model memory and state transitions immutably
- Explore deterministic virtual machine behavior
- Practice modular Haskell system design

Rather than using existing blockchain frameworks, the goal was to build the execution engine from scratch.

---

# 🏗️ System Architecture

```
mini-evm-haskell/
├── src/
│   ├── Instruction.hs   → Defines VM bytecode instructions
│   ├── Stack.hs         → Stack operations (push/pop)
│   ├── Types.hs         → VM state (stack + memory)
│   ├── VM.hs            → Execution engine
├── app/
│   └── Main.hs          → Entry point / program execution
├── mini-evm-haskell.cabal
```

---

## 🔹 Module Responsibilities

### 📦 Instruction.hs
Defines the virtual machine instruction set.

```haskell
data Instruction
  = PUSH Value
  | ADD
  | SUB
  | MUL
  | DIV
  | STORE VarName
  | LOAD VarName
```

---

### 📦 Stack.hs
Implements stack behavior using a list.

- `push`
- `pop`
- Error handling for stack underflow

---

### 📦 Types.hs
Defines the VM state.

```haskell
data VMState = VMState
  { stack  :: Stack
  , memory :: Memory
  }
```

The memory is implemented using:

```haskell
Map.Map String Int
```

---

### 📦 VM.hs
Core execution engine.

```haskell
execute :: VMState -> [Instruction] -> Either String VMState
```

This recursively processes instructions and transforms the VM state.

---

### 📦 Main.hs
Defines and executes example programs.

---

# 🧠 Instruction Set

| Instruction | Description |
|-------------|-------------|
| `PUSH n` | Push value onto stack |
| `ADD` | Pop two values and push sum |
| `SUB` | Pop two values and push difference |
| `MUL` | Pop two values and push product |
| `DIV` | Pop two values and push quotient |
| `STORE name` | Pop value and store in memory |
| `LOAD name` | Push memory value onto stack |

---

## Example Stack Behavior

Program:

```haskell
PUSH 10
PUSH 20
ADD
```

Stack evolution:

```
[]
→ [10]
→ [20,10]
→ [30]
```

This mirrors the behavior of the Ethereum Virtual Machine.

---

# ⚙️ Execution Engine

The VM uses:

- Recursive execution
- Pattern matching on instructions
- Immutable state updates
- Functional error handling via `Either`

Each instruction transforms the VM state into a new state.

No mutation occurs — everything is immutable.

---

# 🧪 Example Program Walkthrough

Defined in `Main.hs`:

```haskell
let program =
  [ PUSH 10
  , PUSH 20
  , ADD
  , STORE "result"
  , LOAD "result"
  , PUSH 2
  , MUL
  ]
```

### Step-by-step execution:

1. Push 10
2. Push 20
3. Add → 30
4. Store "result" = 30
5. Load "result"
6. Push 2
7. Multiply → 60

### Final Output

```
⚡ Mini EVM Haskell
Final VM State:
VMState {stack = [60], memory = fromList [("result",30)]}
```

---

# 🔨 Build & Run

Inside the project directory:

```bash
cabal build
cabal run
```

You should see:

```
⚡ Mini EVM Haskell
Final VM State:
VMState {stack = [60], memory = fromList [("result",30)]}
```

---

# 📸 Screenshots
 
Defines the virtual machine’s bytecode instruction set.  
This module models the core operations supported by the VM, including arithmetic operations (`ADD`, `SUB`, `MUL`, `DIV`), stack manipulation (`PUSH`), and memory operations (`STORE`, `LOAD`).  
It represents the execution language of the virtual machine.
 <img width="960" height="1020" alt="instructions hs" src="https://github.com/user-attachments/assets/38826c18-d289-4c73-9d9b-9b32df90e4e8" />

Stack.hs
 
Implements the stack abstraction used by the virtual machine.  
The stack follows a Last-In-First-Out (LIFO) model and provides safe `push` and `pop` operations with error handling to prevent stack underflow.  
This is the core data structure driving instruction execution.
<img width="960" height="1020" alt="stack hs" src="https://github.com/user-attachments/assets/8bc9c7af-1c8b-4c49-b586-2c84994031b8" />

Types.hs
 
Implements the stack abstraction used by the virtual machine.  
- The stack follows a Last-In-First-Out (LIFO) model and provides safe `push` and `pop` operations with error handling to prevent stack underflow.  
-  This is the core data structure driving instruction execution.
<img width="960" height="1020" alt="types hs" src="https://github.com/user-attachments/assets/2727cb2b-ee0e-4cf6-be82-531f66aa5a3f" />

VM.hs
 
Defines the virtual machine state structure.  
The `VMState` contains:

- The execution stack  
- A memory map for variable storage
  
State transitions are handled immutably, ensuring deterministic execution.
<img width="960" height="1020" alt="vm hs" src="https://github.com/user-attachments/assets/93028bf9-8eb6-450c-b867-2b86615b4557" />

Main.hs

Acts as the program entry point.  
Defines a sample bytecode program and invokes the execution engine.  
This module demonstrates how instructions are composed and executed within the VM runtime.

<img width="960" height="1020" alt="main hs" src="https://github.com/user-attachments/assets/8a692816-eee4-4e31-a878-05f0b0dcf619" />

Output

Displays the final virtual machine state after execution.  
The output confirms:

- Correct arithmetic evaluation  
- Proper memory storage (`result = 30`)  
- Final stack value (`60`)  

This validates the deterministic behavior of the execution engine.
<img width="1920" height="1020" alt="output" src="https://github.com/user-attachments/assets/42f95ac5-239e-4d0d-82bd-39f0a09863d0" />

---

# 🧠 Concepts Demonstrated

- Stack-based virtual machine design
- Bytecode instruction modeling
- Deterministic execution
- Immutable state transitions
- Functional runtime architecture
- Modular Haskell system design
- Safe error handling (`Either`)
- Map-based memory storage
- Execution-layer blockchain modeling

---

# 💡 Why I Built This

I built this project to deeply understand how smart contract execution layers function beneath high-level blockchain frameworks.

Rather than using pre-built libraries, I wanted to:

- Design a bytecode system
- Implement a stack-based runtime
- Model deterministic state transitions
- Explore execution-layer architecture
- Connect functional programming to blockchain concepts

This project represents an execution engine foundation that could later be extended into:

- A full smart contract platform
- A blockchain-integrated runtime
- A DSL-to-bytecode compiler
- A gas-metered execution model

---

# 🚀 Future Improvements

Planned upgrades:

- Gas metering
- Program counter
- Conditional branching (`JMP`, `JZ`)
- Smart contract compilation
- Integration with blockchain project
- Persistent state storage
- CLI contract execution
- Interactive REPL

---

# 👤 Author

Katlego

---

# 📜 License

MIT
