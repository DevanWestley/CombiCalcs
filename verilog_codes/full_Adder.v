`timescale 1ns/1ns
module fa (
    input a, b, c,
    output sum, carry
);

    wire s1, c1, c2;
    xor(s1, a, b);
    xor(sum, s1, c);
    and(c2, s1, c);
    and(c1, a, b);
    or(carry, c1, c2);
    
endmodule

module testb;
    reg a, b, c;
    wire sum, carry;
    
    fa uut ( .a(a), .b(b),.c(c), .sum(sum), .carry(carry));

    initial begin
        $dumpfile("test1.vcd");
        $dumpvars(); //Display GTKWave
        $monitor("a=%b, b=%b, c=%b, carry=%b, sum=%b \n", a, b, c, carry, sum);
        a=0; b=0; c=0; //Sinyal masukan
        #10 a=0; b=0; c=1;
        #10 a=0; b=1; c=0;
        #10 a=0; b=1; c=1;
        #10 a=1; b=0; c=0;
        #10 a=1; b=0; c=1;
        #10 a=1; b=1; c=0;
        #10 a=1; b=1; c=1;
        #10 a=0; b=0; c=0;
        #10 $finish;
    end
endmodule