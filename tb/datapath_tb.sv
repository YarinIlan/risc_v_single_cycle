module datapath_tb;

    logic clk;
    logic rst;

    always #5 clk = ~clk;

    datapath dut(
        .clk(clk),
        .rst(rst)
    );
    
    initial begin
        $dumpfile("sim/dump.vcd");
        $dumpvars(0,datapath_tb);

        clk = 1'b0;
        rst = 1'b1;

        //initializin all temp control wires
        dut.alu_src = 0;
        dut.pc_src = 0;
        dut.reg_write = 0;
        dut.alu_ctrl = 4'b0000;
        dut.imm_src = 3'b000;
        dut.mem_write = 0;
        dut.result_src = 2'b00;
        #20
        rst = 0;
        

        //addi x1, x0, 7
        dut.alu_src = 1;
        dut.pc_src = 0;
        dut.reg_write = 1;
        dut.alu_ctrl = 4'b0000;
        dut.imm_src = 3'b000;
        dut.mem_write = 0;
        dut.result_src = 2'b00;
        #10
        
        //sw x1, 4(x0)
        dut.alu_src = 1;
        dut.pc_src = 0;
        dut.reg_write = 0;
        dut.alu_ctrl = 4'b0000;
        dut.imm_src = 3'b001;
        dut.mem_write = 1;
        dut.result_src = 2'b00;
        #10

        //lw x2, 4(x0)
        dut.alu_src = 1;
        dut.pc_src = 0;
        dut.reg_write = 1;
        dut.alu_ctrl = 4'b0000;
        dut.imm_src = 3'b000;
        dut.mem_write = 0;
        dut.result_src = 2'b01;
        #10




        $finish;
        
    end
    
    
endmodule