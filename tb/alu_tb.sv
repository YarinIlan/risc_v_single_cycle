module alu_tb;

    logic [31:0] a,b;
    logic [3:0] alu_op;
    logic [31:0] result;
    logic zero;

    alu dut(
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    initial begin
        $dumpfile("sim/dump.vcd");
        $dumpvars(0, alu_tb);

        a = 32'h00000005; b = 32'h00000003; alu_op = 4'b0000; // ADD
        #10;
        $display("ADD: %h + %h = %h, zero: %b", a, b, result, zero);

        alu_op = 4'b0001; // SUB
        #10;
        $display("SUB: %h - %h = %h, zero: %b", a, b, result, zero);

        a = 32'h00000005; b = 32'h0000000f; alu_op = 4'b0010; // AND
        #10;
        $display("AND: %h & %h = %h, zero: %b", a, b, result, zero);

        alu_op = 4'b0011; // OR
        #10;
        $display("OR: %h | %h = %h, zero: %b", a, b, result, zero);

        alu_op = 4'b0100; // XOR
        #10;
        $display("XOR: %h ^ %h = %h, zero: %b", a, b, result, zero);

        a = 32'h00000001; b = 32'h00000002; alu_op = 4'b0101; // SHL
        #10;
        $display("SHL: %h << %h = %h, zero: %b", a, b, result, zero);
        
        alu_op = 4'b0110; // SHR
        #10;
        $display("SHR: %h >> %h = %h, zero: %b", a, b, result, zero);

        a = 32'h80000011; b = 32'h00000002;
        alu_op = 4'b0111; // SHRA
        #10;
        $display("SHRA: %h >>> %h = %h, zero: %b", a, b, result, zero);

        a = 32'hffffffff; b = 32'h1; alu_op = 4'b1000; // SLT
        #10;
        $display("SLT: %h < %h = %h, zero: %b", a, b, result, zero);

        alu_op = 4'b1001; // SLTU
        #10;
        $display("SLTU: %h < %h = %h, zero: %b", a, b, result, zero);

        a = 32'h00000005; b = 32'h00000005; alu_op = 4'b0001; // SUB
        #10;
        $display("SUB: %h - %h = %h, zero: %b", a, b, result, zero);

        $finish;
    end
    
endmodule

