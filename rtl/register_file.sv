module regfile(
    input logic clk,rst,write_en,
    input logic [4:0] read_addr1, read_addr2, write_addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data1, read_data2
);

logic [31:0] registers [31:0];

always_ff@(posedge clk or posedge rst) begin
    if(rst) begin
        for(int i=0;i<32;i++) begin
            registers[i]<= 32'b0;
        end
    end else if(write_en & (write_addr != 5'b0)) 
        registers[write_addr] <= write_data;
    
    end

assign read_data1 = (read_addr1 == 5'b0) ? 32'b0 : registers[read_addr1];
assign read_data2 = (read_addr2 == 5'b0) ? 32'b0 : registers[read_addr2];

///////// Icarus-Compatible SystemVerilog Assertions(not compatible with concurrent assertions) /////////
`ifndef SYNTHESIS

logic [4:0] prev_write_addr;
logic prev_write_en;
logic [31:0] prev_write_data;

always@(posedge clk) begin
    if(!rst) begin
        assert(registers[0] == 32'b0) else $fatal(1,"Register 0 is not initialized to zero");

        if(read_addr1 != 5'b0) begin
            assert(read_data1 == registers[read_addr1]) else $fatal(1,"Read data 1 does not match the value in the register file");
        end

        if(read_addr2 != 5'b0) begin
            assert(read_data2 == registers[read_addr2]) else $fatal(1,"Read data 2 does not match the value in the register file");
        end

        if(prev_write_en & (prev_write_addr != 5'b0)) begin
            assert(registers[prev_write_addr] == prev_write_data) else $fatal(1,"Write data does not match the value in the register file");
        end
    end
end

always@(posedge clk) begin
    if(rst) begin
        prev_write_addr <= 5'b0;
        prev_write_en <= 1'b0;
        prev_write_data <= 32'b0;
    end else begin
        prev_write_addr <= write_addr;
        prev_write_en <= write_en;
        prev_write_data <= write_data;
    end
end

`endif

endmodule

    