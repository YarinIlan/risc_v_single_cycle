module control_unit(

    input logic [6:0] op_code,
    input logic [2:0] func3,
    input logic bit30func7,
    input logic zero,
    output logic [1:0] pc_src,
    output logic [2:0] result_src,
    output logic mem_write,
    output logic [3:0] alu_ctrl,
    output logic alu_src,
    output logic [2:0] imm_ctrl,
    output logic reg_write
);

logic [1:0] alu_op;
logic branch;
logic jump;
logic jalr;

control_unit_main_decoder control_unit_main_decoder_instance(
    .op_code(op_code),
    .jump(jump),
    .jalr(jalr),
    .branch(branch),
    .result_src(result_src),
    .mem_write(mem_write),
    .alu_op(alu_op),
    .alu_src(alu_src),
    .imm_ctrl(imm_ctrl),
    .reg_write(reg_write)
);

control_unit_alu_decoder control_unit_alu_decoder_instance(
    .alu_op(alu_op),
    .func3(func3),
    .bit30func7(bit30func7),
    .op5(op_code[5]),
    .alu_ctrl(alu_ctrl)
);

assign pc_src = jalr ? 2'b10 : (jump | (branch & zero)) ? 2'b01 : 2'b00;

///////// Icarus-Compatible SystemVerilog Assertions(not compatible with concurrent assertions) /////////
`ifndef SYNTHESIS
always@(*) begin

    if (^op_code !== 1'bx) begin // Check if op_code is not x or z to let the assertions run only when op_code is valid
        // Add assertions to check for valid control signals(not x or z)
        assert(pc_src == 2'b00 || pc_src == 2'b01 || pc_src == 2'b10) else $fatal(1,"Invalid PC source");
        assert(result_src == 3'b000 || result_src == 3'b001 || result_src == 3'b010 || result_src == 3'b011|| result_src == 3'b100) else $fatal(1,"Invalid Result source");
        assert(mem_write == 1'b0 || mem_write == 1'b1) else $fatal(1,"Invalid Memory Write signal");
        assert(alu_ctrl == 4'b0000 || alu_ctrl == 4'b0001 || alu_ctrl == 4'b0010 || alu_ctrl == 4'b0011 || alu_ctrl == 4'b0100 || alu_ctrl == 4'b0101 || alu_ctrl == 4'b0110 || alu_ctrl == 4'b0111 || alu_ctrl == 4'b1000 || alu_ctrl == 4'b1001 || alu_ctrl == 4'b1010 || alu_ctrl == 4'b1011) else $fatal(1,"Invalid ALU control signal");
        assert(alu_src == 1'b0 || alu_src == 1'b1) else $fatal(1,"Invalid ALU source signal");
        assert(imm_ctrl == 3'b000 || imm_ctrl == 3'b001 || imm_ctrl == 3'b010 || imm_ctrl == 3'b011|| imm_ctrl == 3'b100 ) else $fatal(1,"Invalid Immediate control signal");
        assert(reg_write == 1'b0 || reg_write == 1'b1) else $fatal(1,"Invalid Register Write signal");
       
       // Add assertions to check for mutually exclusive control signals
        assert(!(jump & jalr)) else $fatal(1,"Jump and JALR signals are both active");
        assert(!(branch & jump)) else $fatal(1,"Branch and Jump signals are both active");
        assert(!(branch & jalr)) else $fatal(1,"Branch and JALR signals are both active");
        assert(!(mem_write & reg_write)) else $fatal(1,"Memory Write and Register Write signals are both active");

    end
end
`endif

endmodule