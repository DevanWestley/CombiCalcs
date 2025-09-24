`include "MIPS.h"

module full_adder(
    input a, 
    input b, 
    input cin, 
    output sum, 
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module full_adder_32bit(
    input [`WORD_SIZE-1:0] a, 
    input [`WORD_SIZE-1:0] b, 
    input cin, 
    output [`WORD_SIZE-1:0] sum, 
    output cout
);
    wire [`WORD_SIZE-1:0] carry;

    genvar i;
    generate
        for (i = 0; i < `WORD_SIZE; i = i + 1) begin: full_adder_loop
            if (i == 0) 
                full_adder FA (a[i], b[i], cin, sum[i], carry[i]);
            else 
                full_adder FA (a[i], b[i], carry[i-1], sum[i], carry[i]);
        end
    endgenerate

    assign cout = carry[`WORD_SIZE-1];
endmodule
