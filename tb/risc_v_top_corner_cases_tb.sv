module risc_v_top_corner_cases_tb;

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
        $dumpvars(0, risc_v_top_corner_cases_tb);
        $readmemh("C:/Users/User/Desktop/project risc v/sim/instruction_data_corner_cases.hex", dut.datapath_instance.instruction_memory_instance.instruction_mem);

        clk = 1'b0; //initialize system
        rst = 1'b1;
        #15

        rst = 1'b0;// let the system run
        #350

        if(dut.datapath_instance.regfile_instance.registers[0] != 32'b0)//wrtiting to register 0 test check
            $display("failed: writing to register[0] test failed, register[0] is not 0, clock cycles:%d",clk_cycles);
        else
            $display("success: writing to register[0] test succeed, register[0] is 0, clock cycles: %d", clk_cycles);


        if(dut.datapath_instance.regfile_instance.registers[2] != 32'd2)//shift left test(amount due to last 5 bits)
            $display("failed: over shift left test failed, register[2] is not 2, clock cycles:%d",clk_cycles);
        else
            $display("success: over shift left test succeed, register[2] is 2, clock cycles:%d",clk_cycles);
        

        if(dut.datapath_instance.regfile_instance.registers[3] == 32'hffffffff)//undeflow test check
            $display("success: underflow test succeed, register[3] is 0xffffffff(-1), clock cycles:%d",clk_cycles);
        else
            $display("failed: undeflow test failed, register[3] is not 0xffffffff(-1), clock cycles:%d",clk_cycles);

        if(dut.datapath_instance.regfile_instance.registers[5] != 32'b1)
            $display("failed: slt test failed, register[5] is not 1, clock cycles:%d",clk_cycles);
        else
            $display("success: slt test succeed, register[5] is 1, clock cycles:%d",clk_cycles);

        if(dut.datapath_instance.regfile_instance.registers[6] == 32'b0)
            $display("success: sltu test succeed, register[6] is 0, clock cycles:%d",clk_cycles);
        else
            $display("failed: sltu test failed, register[6] is not 0, clock cycles:%d",clk_cycles);
    end

endmodule