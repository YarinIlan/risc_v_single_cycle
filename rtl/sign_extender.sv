module sign_extender(

    input logic [2:0] imm_src,
    input logic [31:0] instruction,
    output logic [31:0] extended
);

localparam i_type = 3'b000;
localparam s_type = 3'b001;
localparam b_type = 3'b010;
localparam u_type = 3'b011;
localparam j_type = 3'b100;

always@(*) begin
    case(imm_src)

    i_type: extended = {{20{instruction[31]}}, instruction[31:20]};

    s_type: extended = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

    b_type: extended = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};

    u_type: extended = {{instruction[31:12]}, 12'b0};

    j_type: extended = {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};

    default: extended = 32'b0;

    endcase

    end

endmodule