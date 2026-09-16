module regfile_tb;

    logic clk,rst,write_en;
    logic [4:0] read_addr1, read_addr2, write_addr;
    logic [31:0] write_data;
    logic [31:0] read_data1, read_data2;

    regfile dut( // Instantiate the regfile module
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)

    );

    always #5 clk = ~clk; // Clock generation

    initial begin // Initialize signals
    $dumpfile("sim/dump.vcd"); // Dump waveform to a VCD file
    $dumpvars(0, regfile_tb); // Dump variables to the VCD file

        clk = 0;
        rst = 0;
        write_en = 0;
        read_addr1 = 0;
        read_addr2 = 0;
        write_addr = 0;
        write_data = 0;
        

        #10 rst = 1; // Assert reset
        #10 rst = 0; // Deassert reset

        #10 write_en = 1; // Enable write
        write_addr = $urandom_range(1, 31); // Write to a random register
        write_data = $urandom; // Write a random value
        #10 write_en = 0; // Disable write

        read_addr1 = write_addr; // Read from the same register
        read_addr2 = 0; // Read reg 0
        #10; // Wait for a clock cycle

        write_addr = 5'b0; // Write to reg 0
        write_en = 1; // Enable write

        

        $display("read_data1: %h, read_data2(register 0): %h", read_data1, read_data2);
        $display("write_random_data: %h, to_random_register: %h", write_data, write_addr);

        #10
        $finish;

        end
endmodule

        

        
       
     
