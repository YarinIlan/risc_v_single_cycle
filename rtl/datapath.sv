module datapath(

    input logic clk,
    input logic rst,
    input logic alu_src,
    input logic [1:0] pc_src,
    input logic reg_write,
    input logic [3:0] alu_ctrl,
    input logic [2:0] imm_src,
    input logic mem_write,
    input logic [2:0] result_src,
    output logic [6:0] op_code,
    output logic bit30func7,
    output logic [2:0] func3,
    output logic zero_flag
);

logic [31:0] pc_current;
logic [31:0] pc_next;
logic [31:0] instruction;
logic [31:0] read_data1;
logic [31:0] read_data2;
logic [31:0] extended;
logic [31:0] b;
logic [31:0] alu_result;
logic zero;
logic [31:0] mem_read_data;
logic [31:0] write_back_data;
logic [31:0] pc_target;
logic [31:0] pc_inc;


//temp control wires
/////////

pc pc_instance(
    .clk(clk),
    .rst(rst),
    .pc_en(1'b1), //temp
    .pc_in(pc_next),
    .pc_out(pc_current)
);

instruction_memory instruction_memory_instance(
    .addr(pc_current),
    .instruction(instruction)
);

regfile regfile_instance(
    .clk(clk),
    .rst(rst),
    .write_en(reg_write),
    .read_addr1(instruction[19:15]),
    .read_addr2(instruction[24:20]),
    .write_addr(instruction[11:7]),
    .write_data(write_back_data), 
    .read_data1(read_data1),
    .read_data2(read_data2)
);

sign_extender sign_extender_instance(
    .imm_src(imm_src), // 
    .instruction(instruction),
    .extended(extended)
);

alu alu_instance(
    .a(read_data1),
    .b(b),
    .alu_op(alu_ctrl),
    .zero(zero),
    .result(alu_result)
);

data_memory data_memory_instance(
    .clk(clk),
    .write_en(mem_write),//
    .addr(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);







always_comb begin
    case(result_src)
        3'b000: write_back_data = alu_result;
        3'b001: write_back_data = mem_read_data;
        3'b010: write_back_data = pc_inc;
        3'b011: write_back_data = extended;
        3'b100: write_back_data = pc_target;
        default: write_back_data = 32'b0;
    endcase
end

always_comb begin
    case(pc_src)
    2'b00: pc_next = pc_inc;
    2'b01: pc_next = pc_target;
    2'b10: pc_next = alu_result;
    default: pc_next = pc_inc;
    endcase
end

assign pc_inc = pc_current + 32'd4;
assign pc_target = pc_current + extended;
assign b = (alu_src)? extended:read_data2;
assign op_code = instruction[6:0];
assign func3 = instruction[14:12];
assign bit30func7 = instruction[30];
assign zero_flag = zero;


endmodule