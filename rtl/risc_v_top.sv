module risc_v_top(
    input logic clk,
    input logic rst
);

logic alu_src;
logic pc_src;
logic reg_write;
logic [3:0] alu_ctrl;
logic [2:0] imm_src;
logic mem_write;
logic [1:0] result_src;
logic [6:0] op_code;
logic bit30func7;
logic [2:0] func3;
logic zero_flag;

control_unit control_unit_instance(
    .op_code(op_code),
    .func3(func3),
    .bit30func7(bit30func7),
    .zero(zero_flag),
    .pc_src(pc_src),
    .result_src(result_src),
    .mem_write(mem_write),
    .alu_ctrl(alu_ctrl),
    .alu_src(alu_src),
    .imm_ctrl(imm_src),
    .reg_write(reg_write)
);

datapath datapath_instance(
    .clk(clk),
    .rst(rst),
    .alu_src(alu_src),
    .pc_src(pc_src),
    .reg_write(reg_write),
    .alu_ctrl(alu_ctrl),
    .imm_src(imm_src),
    .mem_write(mem_write),
    .result_src(result_src),
    .op_code(op_code),
    .bit30func7(bit30func7),
    .func3(func3),
    .zero_flag(zero_flag)
);

endmodule