module risc_v_top_tb;

    logic clk;
    logic rst;

    risc_v_top dut(
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk; //generate clock

    initial begin
        $dumpfile("sim/dump.vcd"); //create a dump file
        $dumpvars(0, risc_v_top_tb);

        clk = 1'b0; //initialize system
        rst = 1'b1;
        #15

        rst = 1'b0;// let the system run
        #200

        $finish;
    end

endmodule