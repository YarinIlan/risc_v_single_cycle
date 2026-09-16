module sign_extender_tb;

logic [2:0] imm_src;
logic [31:0] instruction;
logic [31:0] extended;

sign_extender dut(

    .imm_src(imm_src),
    .instruction(instruction),
    .extended(extended)
);



initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars (0, sign_extender_tb);

    imm_src = 3'b0;
    instruction = 32'b0;
    #10

    instruction = $urandom;
    #10
    $display("instruction = %h, imm_src = %h, extended = %h", instruction, imm_src, extended);

    imm_src = 3'b001;
    #10
    $display("instruction = %h, imm_src = %h, extended = %h", instruction, imm_src, extended);

    imm_src = 3'b010;
    #10
    $display("instruction = %h, imm_src = %h, extended = %h", instruction, imm_src, extended);

    imm_src = 3'b011;
    #10
    $display("instruction = %h, imm_src = %h, extended = %h", instruction, imm_src, extended);

    imm_src = 3'b100;
    #10
    $display("instruction = %h, imm_src = %h, extended = %h", instruction, imm_src, extended);

    $finish;

end

endmodule
