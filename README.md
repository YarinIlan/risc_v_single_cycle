# risc_v_single_cycle
# RISC-V (RV32I) Single-Cycle Processor Core 💻

![Status: Work in Progress](https://img.shields.io/badge/Status-Work_in_Progress-orange)
![Language: SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-blue)

## 📌 Overview
This repository contains a custom-built, single-cycle RISC-V (RV32I) processor core implemented in **SystemVerilog** from scratch. 
The project focuses on a strict modular RTL design, explicitly separating the Datapath and Control Unit without relying on pre-made templates.

## 🚧 Current Status & Roadmap (Active Development)
The core architecture is fully established and currently under active development.

**Achieved Milestones (Verified at RTL level):**
- [x] Complete Datapath implementation (ALU, Register File, Sign Extender, PC logic).
- [x] Control Unit integration (Main Decoder + ALU Decoder).
- [x] Core memory and I-Type arithmetic instructions working autonomously (e.g., `lw`, `sw`, `addi`).
- [x] Top-level encapsulation and system synchronization.

**Next Steps:**
- [ ] Expand ISA subset (Full R-Type logicals, J-Type jumps, full B-Type branching).
- [ ] Advanced system-level verification with complex assembly algorithms.
- [ ] Add block diagrams for the internal Datapath routing.

## 🏗️ Architecture
The design follows a modular integration approach:
* **Datapath:** Handles all data routing, arithmetic operations, and data memory access.
* **Control Unit:** Dynamically decodes standard RISC-V 32-bit instructions (Opcode, funct3, funct7) to orchestrate the datapath without inferred latches.
* **Top-Level Wrapper:** Encapsulates the system for seamless simulation and validation.

## 🛠️ Tools Used
* **Design:** SystemVerilog
* **Simulation & Verification:** Icarus Verilog, GTKWave
