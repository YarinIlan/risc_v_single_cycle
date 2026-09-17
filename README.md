# RISC-V (RV32I) Single-Cycle Processor Core 💻

## 📌 Overview
This repository contains a custom-built, single-cycle 32-bit RISC-V (RV32I) processor core implemented in SystemVerilog from scratch. The project focuses on a strict modular RTL design, explicitly separating the Datapath and Control Unit without relying on pre-made templates. The design physically realizes the standard RV32I Base Integer Instruction Set Architecture, handling memory load/stores, complex branching, unconditioned jumps, and upper-immediate calculations within a single clock cycle.

## 🚧 Current Status: RTL Complete, Verification Ongoing
The core RTL architecture is fully implemented and has passed initial integration sanity checks. The project is currently entering the comprehensive Verification phase.

**Achieved Milestones (Design Phase):**
* Complete Datapath implementation (ALU, Register File, Sign Extender, PC logic).
* Control Unit integration (Main Decoder + ALU Decoder) utilizing a decoupled control philosophy.
* Full ISA expansion including R-Type logicals/shifts, J-Type jumps, full B-Type branching infrastructure, and U-Type immediate handling.
* Basic system-level sanity checks validated with bare-metal assembly algorithms and waveform analysis via GTKWave.
* Top-level encapsulation and system synchronization.

**Next Steps (Verification Phase):**
* Development of an automated, self-checking Testbench (Golden Model comparison).
* Extensive corner-case testing (e.g., zero-register immutability, misaligned memory access).
* Integration with the official RISC-V Compliance Suite to ensure strict ISA standard compliance.
* Implementation of Functional Coverage and SystemVerilog Assertions (SVA).

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

## 🛠️ Tools Used
* **Design:** SystemVerilog
* **Simulation & Verification:** Icarus Verilog, GTKWave

## 👨‍💻 About the Author
**Yarin Dover Chaim Ilan**
Engineering Student at Ben-Gurion University of the Negev.
Focused on Computer Architecture, RTL, Chip Design, and Hardware Engineering.
