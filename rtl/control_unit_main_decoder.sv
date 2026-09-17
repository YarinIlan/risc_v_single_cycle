module control_unit_main_decoder(
input logic [6:0] op_code,
output logic branch,
output logic jump,
output logic jalr,
output logic [2:0] result_src,
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
localparam jal = 7'b1101111;
localparam jalr_op = 7'b1100111;
localparam lui = 7'b0110111;
localparam auipc = 7'b0010111;
localparam nop = 13'b0000000000000;


always_comb begin
    case(op_code)

        lw:      {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_001_0_00_1_000_1;
        sw:      {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_000_1_00_1_001_0;
        r_type:  {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_000_0_10_0_000_1;
        i_type:  {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_000_0_10_1_000_1;
        beq:     {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_1_000_0_01_0_010_0;
        jal:     {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_1_0_010_0_00_0_100_1;
        jalr_op: {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b1_0_0_010_0_00_1_000_1;
        lui:     {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_011_0_00_1_011_1; 
        auipc:   {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = 14'b0_0_0_100_0_00_1_011_1; 
        default: {jalr, jump, branch, result_src, mem_write, alu_op, alu_src, imm_ctrl, reg_write} = nop;
    endcase
end


endmodule