module data_memory_tb;

logic clk;
logic write_en;
logic [31:0] addr;
logic [31:0] write_data;
logic [31:0] read_data;


data_memory dut(
    .clk(clk),
    .write_en(write_en),
    .addr(addr),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;


initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars(0,data_memory_tb);

    clk = 1'b0;
    write_en = 1'b0;
    addr = 32'b0;
    write_data = 32'b0;

    #10
    write_data = 32'hfcafe111;
    addr = 32'h00000004;

    $display("Before Write: addr[%h], read_data = %h", addr, read_data);

    write_en = 1'b1;
    #10

    write_en = 1'b0;
    #10

    $display("After Write: addr[%h], read_data = %h", addr, read_data);

    
    $finish;

end

endmodule
