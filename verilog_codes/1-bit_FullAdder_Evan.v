`timescale 1ns/1ns

module full_adder (
    input A, B, Cin,
    output S, Cout
);

    assign S = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule

// Testbench for the full adder
module testbench;
    reg A, B, Cin;
    wire S, Cout;

    full_adder uut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, testbench);

        $monitor("A=%b, B=%b, Cin=%b -> S=%b, Cout=%b", A, B, Cin, S, Cout);

        A = 0; B = 0; Cin = 0; #10;
        A = 0; B = 0; Cin = 1; #10;
        A = 0; B = 1; Cin = 0; #10;
        A = 0; B = 1; Cin = 1; #10;
        A = 1; B = 0; Cin = 0; #10;
        A = 1; B = 0; Cin = 1; #10;
        A = 1; B = 1; Cin = 0; #10;
        A = 1; B = 1; Cin = 1; #10;

        $finish;
    end
endmodule
