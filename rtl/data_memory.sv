module data_memory(

    input logic clk,
    input logic write_en,
    input logic [31:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);

logic [7:0] addr_index;
logic [31:0] memory [255:0];

initial begin
    $readmemh("C:/Users/User/Desktop/project risc v/sim/data.hex",memory);
end

always_ff@(posedge clk) begin
    if(write_en) begin
        memory[addr_index] <= write_data;
    end
end


assign addr_index = addr[9:2];
assign read_data = memory[addr_index];

endmodule
