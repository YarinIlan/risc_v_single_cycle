# RISC-V (RV32I) Single-Cycle Processor Core 💻

## 📌 Overview
This repository contains a custom-built, single-cycle 32-bit RISC-V (RV32I) processor core implemented in SystemVerilog from scratch. The project focuses on a strict modular RTL design, explicitly separating the Datapath and Control Unit without relying on pre-made templates. The design physically realizes the standard RV32I Base Integer Instruction Set Architecture, handling memory load/stores, complex branching, unconditioned jumps, and upper-immediate calculations within a single clock cycle.

## 🚀 Project Status: Complete & Verified
The core architecture is fully implemented and verified at the RTL level.
**Achieved Milestones:**
* Complete Datapath implementation (ALU, Register File, Sign Extender, PC logic).
* Control Unit integration (Main Decoder + ALU Decoder) utilizing a decoupled control philosophy.
* Full ISA expansion including R-Type logicals/shifts, J-Type jumps, full B-Type branching infrastructure, and U-Type immediate handling.
* Advanced system-level verification validated with complex, bare-metal assembly algorithms.
* Top-level encapsulation and system synchronization.

## ⚙️ Supported Instruction Set (RV32I)
The core successfully executes the following instruction categories:
* **R-Type:** `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu`
* **I-Type:** `addi`, `slli`, `srli`, `srai`, `slti`, `sltiu`, `andi`, `ori`, `xori`
* **S-Type & Load:** `sw`, `lw`
* **B-Type:** `beq` (Infrastructure supports easy expansion to `bne`, `blt`, `bge`)
* **J-Type:** `jal`, `jalr` (Full support for function calls and return address linking)
* **U-Type:** `lui`, `auipc`

## 🏗️ Architecture
The design follows a modular integration approach:
* **Datapath:** Handles all data routing, arithmetic operations via a 10-operation ALU (Arithmetic, Logical, Shifts), and data memory access.
* **Control Unit:** Dynamically decodes standard RISC-V 32-bit instructions (Opcode, funct3, bit30) to orchestrate the datapath without inferred latches. Separated into a `main_decoder` (dispatching a 14-bit control vector) and an `alu_decoder`.
* **Top-Level Wrapper:** Encapsulates the system for seamless simulation and validation.

## 🔬 Verification & Testing
The processor's functionality was validated by executing comprehensive assembly programs compiled into machine code (Hex). Integration tests exercise register dependencies, memory access consistency, and control flow validation. Waveform analysis was conducted in **GTKWave** to ensure flawless signal propagation, correct PC calculation, and zero timing violations.

## 🛠️ Tools Used
* **Design:** SystemVerilog
* **Simulation & Verification:** Icarus Verilog, GTKWave

## 👨‍💻 About the Author
**Yarin Ilan**
Engineering Student at Ben-Gurion University of the Negev.
Focused on Computer Architecture, RTL, Chip Design, and Hardware Engineering.
