module control_unit_alu_decoder(
    input logic [1:0] alu_op,
    input logic [2:0] func3,
    input logic bit30func7,
    input logic op5,
    output logic [3:0] alu_ctrl
);

localparam add = 2'b00;
localparam sub = 2'b01;
localparam other = 2'b10;

always_comb begin 
    case(alu_op)
        add: alu_ctrl = 4'b0000;
        sub: alu_ctrl = 4'b0001;
        other: begin
            case(func3)
                3'b000: begin
                    if(op5 & bit30func7)
                        alu_ctrl = 4'b0001;
                    else
                        alu_ctrl = 4'b0000;
                end
                3'b010: alu_ctrl = 4'b1000;
               
                3'b110: alu_ctrl = 4'b0011;

                3'b111: alu_ctrl = 4'b0010;  

                default: alu_ctrl = 4'b0000;
            endcase
        end
        default: alu_ctrl = 4'b0000;

    endcase
    
end


endmodule