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

endmodule