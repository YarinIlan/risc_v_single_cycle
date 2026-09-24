module instruction_memory(

    input logic [31:0] addr,
    output logic [31:0] instruction
);

logic [31:0] instruction_mem [0:255];

assign instruction = instruction_mem[addr[9:2]]; // word aligned address + reduced to 8 bits for 256 instructions

endmodule

    

    
