module risc_v_top_compliance_add_tb;

    logic clk;
    logic rst;

    int clk_cycles = 0; //clock cycle counter

    risc_v_top dut(
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk; //generate clock
    always_ff@(posedge clk) begin
        clk_cycles <= clk_cycles + 1;
    end

    initial begin
        $dumpfile("sim/dump.vcd"); //create a dump file
        $dumpvars(0, risc_v_top_compliance_add_tb);
        $readmemh("instruction_data_compliance_add.hex", dut.datapath_instance.instruction_memory_instance.instruction_mem);

        clk = 1'b0; //initialize system
        rst = 1'b1;
        #15

        rst = 1'b0;// let the system run
        #350

        $writememh("sim/signature.output", dut.datapath_instance.data_memory_instance.memory);
    end

endmodule
