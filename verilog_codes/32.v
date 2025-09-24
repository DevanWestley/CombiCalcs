// 1-bit Full Adder Module
module full_adder (
    input a,        // First operand bit
    input b,        // Second operand bit
    input cin,      // Carry-in bit
    output sum,     // Sum output
    output cout     // Carry-out bit
);
    assign sum = a ^ b ^ cin;  // Sum calculation
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out calculation
endmodule

// 32-bit Ripple Carry Adder
module adder_32bit (
    input [31:0] a,  // 32-bit operand A
    input [31:0] b,  // 32-bit operand B
    input cin,       // Initial carry-in
    output [31:0] sum, // 32-bit sum output
    output cout       // Final carry-out bit
);
    wire [31:0] carry; // Internal carry signals
    
    // Instantiate 32 full adders
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : adder_loop
            if (i == 0) begin
                full_adder FA (
                    .a(a[i]), .b(b[i]), .cin(cin), 
                    .sum(sum[i]), .cout(carry[i])
                );
            end else begin
                full_adder FA (
                    .a(a[i]), .b(b[i]), .cin(carry[i-1]), 
                    .sum(sum[i]), .cout(carry[i])
                );
            end
        end
    endgenerate
    
    assign cout = carry[31]; // Final carry-out
endmodule
