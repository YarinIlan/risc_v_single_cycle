module risc_v_top_sum_arr_tb;

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
        $dumpvars(0, risc_v_top_sum_arr_tb);
        $readmemh("instruction_data_sum_arr.hex", dut.datapath_instance.instruction_memory_instance.instruction_mem);

        clk = 1'b0; //initialize system
        rst = 1'b1;
        #15

        rst = 1'b0;// let the system run
        #350

        if(dut.datapath_instance.data_memory_instance.memory[0] == 32'd15) //write to memory check
            $display("success: 15 value is written to memory[0], clock cycles:%d", clk_cycles);
        else    
            $display("failed: failed to write 15 value to mem[0], clock cycles:%d", clk_cycles);

        if(dut.datapath_instance.regfile_instance.registers[2] == 32'd15 && dut.datapath_instance.regfile_instance.registers[1] == 32'd0) // sum value and decremented counter check
                 $display("success: 15 value is written to reg[2] and reg[1], clock cycles:%d", clk_cycles);
        else 
            $display("failed: failed to write 15 value to reg[2] and reg[1], clock cycles:%d", clk_cycles);
        $finish;
    end

endmodule
