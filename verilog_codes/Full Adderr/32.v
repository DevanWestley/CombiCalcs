// 32-bit Full Adder in Verilog with Carry-in and Overflow Detection
module full_adder_32bit(
    input  [31:0] A,
    input  [31:0] B,
    input         Cin,
    output [31:0] Y,
    output        Cout,
    output        Overflow
);
    assign {Cout, Y} = A + B + Cin; // Perform 32-bit addition with carry-in and carry-out
    assign Overflow = (A[31] & B[31] & ~Y[31]) | (~A[31] & ~B[31] & Y[31]); // Overflow detection
endmodule

// Testbench for 32-bit Full Adder
module tb_full_adder_32bit;
    reg  [31:0] A, B;
    reg         Cin;
    wire [31:0] Y;
    wire        Cout, Overflow;
    
    // Instantiate the Full Adder
    full_adder_32bit uut (
        .A(A), 
        .B(B), 
        .Cin(Cin),
        .Y(Y), 
        .Cout(Cout),
        .Overflow(Overflow)
    );
    
    initial begin
        // Dump waveform for GTKWave
        $dumpfile("full_adder_32bit.vcd");
        $dumpvars(0, tb_full_adder_32bit);
        
        // Test Case 1: A = 0xFFFFFF01, B = 0x0000001A, Cin = 0
        A = 32'hFFFFFF01;
        B = 32'h0000001A;
        Cin = 0;
        #10;
        $display("Test 1: A = %h, B = %h, Cin = %b, Y = %h, Cout = %b, Overflow = %b", A, B, Cin, Y, Cout, Overflow);
        
        // Test Case 2: A = 0x12345678, B = 0x87654321, Cin = 1
        A = 32'h12345678;
        B = 32'h87654321;
        Cin = 1;
        #10;
        $display("Test 2: A = %h, B = %h, Cin = %b, Y = %h, Cout = %b, Overflow = %b", A, B, Cin, Y, Cout, Overflow);
        
        // Test Case 3: A = 0xAAAAAAAA, B = 0x55555555, Cin = 0
        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        Cin = 0;
        #10;
        $display("Test 3: A = %h, B = %h, Cin = %b, Y = %h, Cout = %b, Overflow = %b", A, B, Cin, Y, Cout, Overflow);
        
        // Test Case 4: Overflow Case - Large Positive Numbers, Cin = 1
        A = 32'h7FFFFFFF;
        B = 32'h00000001;
        Cin = 1;
        #10;
        $display("Test 4: A = %h, B = %h, Cin = %b, Y = %h, Cout = %b, Overflow = %b", A, B, Cin, Y, Cout, Overflow);
        
        // Test Case 5: Overflow Case - Large Negative Numbers, Cin = 0
        A = 32'h80000000;
        B = 32'h80000000;
        Cin = 0;
        #10;
        $display("Test 5: A = %h, B = %h, Cin = %b, Y = %h, Cout = %b, Overflow = %b", A, B, Cin, Y, Cout, Overflow);
        
        $finish;
    end
endmodule
