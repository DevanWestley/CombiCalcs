`timescale 1ns/1ns

module ALU (
    input A, B, Cin, 
    input [2:0] ALUOp, 
    output reg Result, Cout
);

    wire sum, carry_out;
    full_adder FA (
        .A(A), .B(ALUOp[2] ? ~B : B), .Cin(ALUOp[2] ? 1'b1 : Cin),
        .S(sum), .Cout(carry_out)
    );

    always @(*) begin
        case (ALUOp)
            3'b000: {Cout, Result} = {1'b0, A & B};   // AND
            3'b001: {Cout, Result} = {1'b0, A | B};   // OR
            3'b010: {Cout, Result} = {carry_out, sum}; // ADD
            3'b011: {Cout, Result} = {1'b0, A ^ B};   // XOR
            3'b100: {Cout, Result} = {1'b0, ~(A & B)}; // NAND
            3'b101: {Cout, Result} = {1'b0, ~(A | B)}; // NOR
            3'b110: {Cout, Result} = {carry_out, sum}; // SUB (A - B)
            3'b111: {Cout, Result} = {1'b0, sum};      // SLT (Set on Less Than)
            default: {Cout, Result} = {1'b0, 1'b0};    // Default case
        endcase
    end

endmodule

module full_adder (
    input A, B, Cin,
    output S, Cout
);
    assign S = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule

module testbench;
    reg A, B, Cin;
    reg [2:0] ALUOp;
    wire Result, Cout;

    ALU uut (.A(A), .B(B), .Cin(Cin), .ALUOp(ALUOp), .Result(Result), .Cout(Cout));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, testbench);

        $monitor("A=%b, B=%b, Cin=%b, ALUOp=%b -> Result=%b, Cout=%b", 
                  A, B, Cin, ALUOp, Result, Cout);

        A = 1; B = 0; Cin = 0;

        #10 ALUOp = 3'b000; // AND
        #10 ALUOp = 3'b001; // OR
        #10 ALUOp = 3'b010; // ADD
        #10 ALUOp = 3'b011; // XOR
        #10 ALUOp = 3'b100; // NAND
        #10 ALUOp = 3'b101; // NOR
        #10 ALUOp = 3'b110; // SUB
        #10 ALUOp = 3'b111; // SLT

        #10 $finish;
    end
endmodule
