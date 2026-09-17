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

endmodule

    