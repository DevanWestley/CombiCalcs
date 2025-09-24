`timescale 1ns/1ps

module testbench;
    reg [`WORD_SIZE-1:0] a, b;
    reg cin;
    wire [`WORD_SIZE-1:0] sum;
    wire cout;

    full_adder_32bit FA32 (a, b, cin, sum, cout);

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, testbench);

        // Test Case 1: 0xFFFFFFFF + 0x00000001 (Overflow case)
        a = 32'hFFFFFFFF;  
        b = 32'h00000001;  
        cin = 0;
        #10;

        // Test Case 2: 0x12345678 + 0x87654321
        a = 32'h12345678;
        b = 32'h87654321;
        cin = 1;
        #10;

        // Test Case 3: 0xA5A5A5A5 + 0x5A5A5A5A
        a = 32'hA5A5A5A5;
        b = 32'h5A5A5A5A;
        cin = 0;
        #10;

        // Test Case 4: 0xFFFFFFFF + 0xFFFFFFFF
        a = 32'hFFFFFFFF;
        b = 32'hFFFFFFFF;
        cin = 1;
        #10;

        $finish;
    end
endmodule
