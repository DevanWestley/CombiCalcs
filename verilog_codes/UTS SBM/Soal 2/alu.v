`timescale 1ns/1ps

module alu(
    aluSrc,	
    data1,	// data dari register 1
    data2,	// data dari resgiter 2
    imm,	// nilai immediate
    aluCtrl,	// sinyal ALU Control
    result,	// output result
    zero,	// zero flag
    overflow	// overflow flag
);
    input wire aluSrc;		// memilih operand kedua berasal dari data2 atau immediate
    input wire [31:0] data1;	// operand pertama
    input wire [31:0] data2;	// operand kedua jika aluSrc == 0
    input wire [31:0] imm;	// operand immediate jika aluSrc == 1
    input wire [3:0] aluCtrl;

    output reg [31:0] result;	// hasil operasi
    output wire zero;		// zero flag jika hasil == 0
    output wire overflow;

    wire [31:0] d2;	// operand kedua akhir, bisa berasal dari data2 atau imm
    wire [31:0] sum;	// hasil dari operasi add atau sub
    wire carry;		// carry dari full adder
    wire op;		// flag, 1 == sub dan 0 == add

// zero flag
// zero akan bernilai == 1 jika result == 0
    assign zero = (result == 32'b0) ? 1 : 0;

// jika aluCtrl == 2 (SUB) atau == 3 (SUBU), maka merupakan operasi pengurangan (op == 1)
// jika tidak, akan dianggap penjumlahan (op == 0)
    assign op = (aluCtrl == 2) ? 1 : (aluCtrl == 3) ? 1 : 0;

// menentukan nilai operand kedua
// aluSrc == 0, maka operand kedua menggunakan data2
// aluSrc == 1, maka operand kedua menggunakan imm
    assign d2 = (aluSrc == 0) ? data2 : imm;

// mendeteksi overflow
    wire add_overflow, sub_overflow;

// overflow pada penjumlahan bertanda (signed)
    assign add_overflow = ((data1[31] == d2[31]) && (data1[31] != sum[31]));

// overflow pada pengurangan bertanda (signed)
    assign sub_overflow = ((data1[31] != d2[31]) && (data1[31] != sum[31]));
    assign overflow = (aluCtrl == 4'b0000) ? add_overflow : (aluCtrl == 4'b0010) ? sub_overflow : 1'b0;

    fullAddSub32 addsub(.num1(data1), .num2(d2), .op(op), .sumO(sum), .carryO(carry));

// operasi ALU
    always @(*) begin
        case (aluCtrl)
            4'b0000: result = sum;              // ADD
            4'b0001: result = sum;              // ADDU
            4'b0010: result = sum;              // SUB
            4'b0011: result = sum;              // SUBU
            4'b0100: result = data1 & data2;    // AND
            4'b0101: result = data1 | data2;    // OR
            4'b0110: result = data1 << data2;   // SLL
            4'b0111: result = data1 >> data2;   // SRL
            4'b1000: result = (data1 < data2) ? 1 : 0; // SLT
	    4'b1001: result = (data1 == data2) ? 1 : 0; // BEQ
            4'b1010: result = (data1 != data2) ? 1 : 0; // BNE
            default: result = 0;
        endcase
    end
endmodule