module control_unit_main_decoder(
input logic [6:0] op_code,
output logic branch,
output logic [1:0] result_src,
output logic mem_write,
output logic [1:0] alu_op, //00 add 01 sub 10 let func3and7 decide
output logic alu_src,
output logic [2:0] imm_ctrl,
output logic reg_write
);


localparam  lw = 7'b0000011;
localparam  sw = 7'b0100011;
localparam r_type = 7'b0110011;
localparam i_type = 7'b0010011;
localparam beq = 7'b1100011;
localparam nop = 11'b00000000000;

always_comb begin
    case(op_code)

        lw: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 11'b00100010001;
        sw: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 11'b00010010010;
        r_type: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 11'b00001000001;
        i_type: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 11'b00001010001;
        beq: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 11'b10000100100;
        default: {branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = nop;

    endcase
end

endmodule