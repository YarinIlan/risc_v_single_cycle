# RISC-V (RV32I) Single-Cycle Processor Core 💻

## 📌 Overview
This repository contains a custom-built, single-cycle 32-bit RISC-V (RV32I) processor core implemented in SystemVerilog from scratch. The project focuses on a strict modular RTL design, explicitly separating the Datapath and Control Unit without relying on pre-made templates. The design physically realizes the standard RV32I Base Integer Instruction Set Architecture, handling memory load/stores, complex branching, unconditioned jumps, and upper-immediate calculations within a single clock cycle.

## ✅ Project Status: Completed
The core RTL architecture is fully implemented and verified. The project has successfully passed self-checking integration tests, corner-case validations, and generates correct compliance signatures against the official RISC-V standard.

## 🚀 Achieved Milestones (Design & Verification)
- [x] **Complete Datapath implementation** (ALU, Register File, Sign Extender, PC logic).
- [x] **Control Unit integration** (Main Decoder + ALU Decoder) utilizing a decoupled control philosophy.
- [x] **Full ISA expansion** including R-Type logicals/shifts, J-Type jumps, full B-Type branching infrastructure, and U-Type immediate handling.
- [x] **Basic system-level sanity checks** validated with bare-metal assembly algorithms and waveform analysis via GTKWave.
- [x] **Top-level encapsulation** and system synchronization.
- [x] **Development of an automated, self-checking Testbench.**
- [x] **Extensive corner-case testing** (e.g., zero-register immutability, out-of-bounds shifts, arithmetic underflows).
- [x] **Integration with the official RISC-V Compliance Suite** to ensure strict ISA standard compliance via Signature Dumps.
- [x] **Hardware Verification**: Implementation of SystemVerilog Assertions (SVA) for active runtime monitoring.
- [x] **Generation of comprehensive Architectural Block Diagrams.**

## 🏗️ Architecture
The design follows a modular integration approach:
- **Datapath:** Handles all data routing, arithmetic operations via a 10-operation ALU (Arithmetic, Logical, Shifts), and data memory access.
- **Control Unit:** Dynamically decodes standard RISC-V 32-bit instructions (Opcode, funct3, bit30) to orchestrate the datapath without inferred latches. Separated into a `main_decoder` (dispatching a 14-bit control vector) and an `alu_decoder`.
- **Top-Level Wrapper:** Encapsulates the system for seamless simulation and validation.

![RISC-V Datapath](images/risc_v_scheme.png)

## ⚙️ Supported Instruction Set (RV32I)
The core successfully executes the following instruction categories:
- **R-Type:** `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu`
- **I-Type:** `addi`, `slli`, `srli`, `srai`, `slti`, `sltiu`, `andi`, `ori`, `xori`
- **S-Type & Load:** `sw`, `lw`
- **B-Type:** `beq` (Infrastructure supports easy expansion to `bne`, `blt`, `bge`)
- **J-Type:** `jal`, `jalr` (Full support for function calls and return address linking)
- **U-Type:** `lui`, `auipc`


## 🏅 RISC-V Compliance & Verification
To ensure the processor strictly adheres to the RISC-V standard, the verification environment is designed to execute official **RISC-V Architecture Test Suite** programs. 

The testbench dynamically loads compiled `.hex` compliance tests and utilizes a memory-dump mechanism (`$writememh`) to export the Data Memory contents upon test completion. This output is then compared against the official **Golden Signature**. 

**Example: `ADD` Instruction Compliance Signature (Passed)**
```text
0x00000000 // (Data Memory Output)
0000000f   // Result of 5 + 10
00000000   // Result of -1 + 1 (Arithmetic Overflow/Zero check)


🛡️ Hardware Verification & Assertions (SVA)
To ensure hardware reliability and dynamically catch edge-case bugs during simulation, the processor's core modules are instrumented with runtime assertions. To maintain compatibility with Icarus Verilog while preserving industrial verification standards, these are implemented as Icarus-Compatible Immediate Assertions wrapped in `ifndef SYNTHESIS macros to ensure zero synthesis overhead.

Key architectural invariants verified at runtime include:

Control Unit: Mutual exclusion checks (e.g., preventing simultaneous mem_write and jump/branch operations) and strict validation of all legal control signal states.

Register File: Hardware-level enforcement of x0 (Zero Register) immutability, along with synchronous write and asynchronous read verification across clock cycles.

Program Counter (PC): Strict verification of 4-byte memory alignment for all instruction fetches and branch targets.

ALU: Validation of legal ALU opcodes and strict correlation checks between the operational result and the zero flag, complete with 'X' (unknown) state protection during Time-0 initialization.



🚀 How to Run (Simulation)
This project is simulated using Icarus Verilog and analyzed with GTKWave.

Compile the design:

Bash
iverilog -g2012 -o processor_sim tb/testbench.sv rtl/*.sv
Run the simulation:

Bash
vvp processor_sim
View Waveforms:

Bash
gtkwave dump.vcd


##🔮 Future Enhancements
[ ] Functional Coverage analysis via SystemVerilog covergroups.
[ ] Pipelining the Datapath (5-Stage Pipeline).



##🛠️ Tools Used
Design: SystemVerilog
Simulation & Verification: Icarus Verilog, GTKWave



##👨‍💻 About the Author
Yarin Ilan
Engineering Student at Ben-Gurion University of the Negev.
Focused on Computer Architecture, RTL, Chip Design, and Hardware Engineering.
