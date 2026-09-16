module instruction_memory_tb; 
    
    logic [31:0] addr;
    logic [31:0] instruction;

    instruction_memory dut(
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("sim/dump.vcd");
        $dumpvars(0, instruction_memory_tb);

        // Test case 1: Read instruction at address 0
        addr = 32'h00000000;
        #10;
        $display("Instruction at address %h: %h", addr, instruction);

        // Test case 2: Read instruction at address 4
        addr = 32'h00000004;
        #10;
        $display("Instruction at address %h: %h", addr, instruction);

        // Test case 3: Read instruction at address 8
        addr = 32'h00000008;
        #10;
        $display("Instruction at address %h: %h", addr, instruction);

        // Test case 4: Read instruction at address 12
        addr = 32'h0000000C;
        #10;
        $display("Instruction at address %h: %h", addr, instruction);

        // Test case 5: Read instruction at address 16
        addr = 32'h00000010;
        #10;
        $display("Instruction at address %h: %h", addr, instruction);
    end

endmodule

   