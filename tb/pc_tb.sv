module pc_tb;

    logic clk;
    logic rst;
    logic pc_en;
    logic [31:0] pc_in;
    logic [31:0] pc_out;

    pc dut(
        .clk(clk),
        .rst(rst),
        .pc_en(pc_en),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/dump.vcd");
        $dumpvars(0, pc_tb);

        clk = 0;
        rst = 1;
        pc_en = 0;
        pc_in = 0;

        #10;
        rst = 0;
        pc_in = $urandom;
        #10;
        $display("pc_in: %h, pc_out: %h", pc_in, pc_out);

        pc_en = 1;
        #10;
        $display("pc_in: %h, pc_out: %h", pc_in, pc_out);

        rst = 1;
        #10;
        
        $finish;
    end

endmodule


        


        