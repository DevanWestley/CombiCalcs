module aluCtrl (
    aluOp,
    fn,
    aluCtrl
    );
    input wire [1:0] aluOp; 	// menentukan jenis instruksi
    input wire [5:0] fn;	// function code untuk instruksi R-type (6 bit)
    output reg [3:0] aluCtrl;	// output kendali ke ALU yang memilih operasi AND, OR, dsb

// konstanta function code pada instruksi R-type
parameter ADDFN = 6'b100000;	// ADD
parameter ADDUFN = 6'b100001;	// ADD UNSIGNED
parameter SUBFN = 6'b100010;	// SUBTRACT
parameter SUBUFN = 6'b100011;	// SUBTRACT UNSIGNED
parameter ANDFN = 6'b100100;	// AND
parameter ORFN = 6'b100101;	// OR
parameter SLLFN = 6'b000000;	// SHIFT LEFT LOGICAL
parameter SRLFN = 6'b000010;	// SHIFT RIGHT LOGICAL
parameter SLTFN = 6'b101010;	// SET LESS THAN

reg [3:0] fno;

/* aluCtrl: 
    0: Add
    1: addu
    2: subtract
    3: subu
    4: and
    5: or
    6: sll
    7: srl
    8: slt
    9: beq
   10: bne

*/

// menerjemahkan function code (fn) R-type menjadi kode operasi ALU 4 bit yang disimpan ke fno
// contoh, jika instruksinya ADD dengan fn = 6'b100000, maka fno = 4'b0000
// jika nilai fn tidak dikenali, maka fno akan diset default 4'b0000 yang berarti operasi ADD
    always @ (fn)
    begin
        case(fn)
            ADDFN: fno = 4'b0000;
            ADDUFN: fno = 4'b0001;
            SUBFN: fno = 4'b0010;
            SUBUFN: fno = 4'b0011;
            ANDFN: fno = 4'b0100;
            ORFN: fno = 4'b0101;
            SLLFN: fno = 4'b0110;
            SRLFN: fno = 4'b0111;
            SLTFN: fno = 4'b1000;
            default: fno = 4'b0000;
        endcase
    end

/* ALUOP: 2 bits: 
00 RTYPE
01 SW LW ADDI 
10 BEQ
11 BNE
*/

    always @ (aluOp)
    begin
        case(aluOp)
            2'b00: aluCtrl = fno; 	// R-type, menggunakan hasil dari fno
            2'b01: aluCtrl = 4'b0000;	// ADD menggunakan immediate 
            2'b10: aluCtrl = 4'b1001;	// BEQ, kode spesial 9
            2'b11: aluCtrl = 4'b1010;	// BNE, kode spesial 10
            default: aluCtrl = 4'b0000;
        endcase
    end
endmodule