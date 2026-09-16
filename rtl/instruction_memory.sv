module instruction_memory(

    input logic [31:0] addr,
    output logic [31:0] instruction
);

logic [31:0] instruction_mem [0:255];

initial begin
    $readmemh("C:/Users/User/Desktop/project risk v/sim/instruction_data.hex", instruction_mem);
end

assign instruction = instruction_mem[addr[9:2]]; // word aligned address + reduced to 8 bits for 256 instructions

endmodule

    

    