module pc(
    input logic clk,
    input logic rst,
    input logic pc_en,
    input logic [31:0] pc_in,
    output logic [31:0] pc_out
);

always_ff@(posedge clk or posedge rst) begin
    if(rst) begin
        pc_out <= 32'b0;
    end else if(pc_en) begin
        pc_out <= pc_in;
    end

end

///////// Icarus-Compatible SystemVerilog Assertions(not compatible with concurrent assertions) /////////
`ifndef SYNTHESIS
always@(posedge clk) begin
    if(!rst) begin
        assert(pc_out[1:0] == 2'b00) else $fatal(1,"PC is not aligned to 4 bytes");
    end
end
`endif


endmodule

