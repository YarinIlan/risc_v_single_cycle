module alu(
    input [31:0] a,b,
    input [3:0] alu_op,
    output logic [31:0] result,
    output logic zero
);

logic [4:0] shft_amt;

localparam
    ADD = 4'b0000,
    SUB = 4'b0001,
    AND = 4'b0010,
    OR  = 4'b0011,
    XOR = 4'b0100,
    SHL = 4'b0101,
    SHR = 4'b0110,
    SHRA = 4'b0111,
    SLT = 4'b1000,
    SLTU= 4'b1001;

always_comb begin
    
    case(alu_op) 
        
        ADD : result = a + b;

        SUB : result = a - b;
        
        AND : result = a & b;

        OR : result = a | b;

        XOR : result = a ^ b;

        SHL : result = a << shft_amt;

        SHR : result = a >> shft_amt;

        SHRA: result = $signed(a) >>> shft_amt;

        SLT : result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;

        SLTU: result = (a < b) ? 32'b1 : 32'b0;

        default: result = 32'b0;

        endcase

        
    end
    

assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
assign shft_amt = b[4:0];

///////// Icarus-Compatible SystemVerilog Assertions(not compatible with concurrent assertions) /////////
`ifndef SYNTHESIS
always@(*) begin
    if((^alu_op !== 1'bx) && (^result !== 1'bx) && (zero !== 1'bx)) begin // Check if alu_op, result, and zero are not x or z to let the assertions run only when they are valid
        // Add assertions to check for valid ALU operations
        assert(alu_op == ADD || alu_op == SUB || alu_op == AND || alu_op == OR || alu_op == XOR || alu_op == SHL || alu_op == SHR || alu_op == SHRA || alu_op == SLT || alu_op == SLTU) else $fatal(1,"Invalid ALU operation");
        
        // Add assertions to check if the zero flag is set correctly based on the result
        if(result == 32'b0) begin
            assert(zero == 1'b1) else $fatal(1,"Zero flag is not set when result is zero");
        end else begin
            assert(zero == 1'b0) else $fatal(1,"Zero flag is set when result is not zero");
        end
    end
end
`endif
    
endmodule
