/*
Control instructions <http://alumni.cs.ucr.edu/~vladimir/cs161/mips.html> 
*/
module control(
    opcode,
    dstReg,
    jmp,
    branch,
    MemRead,
    MemtoReg,
    ALUop,
    MemWrite,
    ALUSrc,
    RegWrite
);
// opcodes :
/* R-TYPE : opcode 000000 */
parameter ADD = 6'b000000;
parameter ADDU = 6'b000000;
parameter SUB = 6'b000000;
parameter SUBU = 6'b000000;
parameter AND = 6'b000000;
parameter OR = 6'b000000;
parameter SLL = 6'b000000;
parameter SRL = 6'b000000;
parameter SLT = 6'b000000;

parameter ADDI = 6'b001000;
parameter LW = 6'b100011;
parameter SW = 6'b101011;
parameter BEQ = 6'b000100;
parameter BNE = 6'b000101;
parameter J = 6'b000010;

input wire [5:0] opcode;
output reg [1:0] ALUop;
output reg dstReg; // 0 rt, 1 rd 
output reg jmp;
output reg branch;
output reg MemRead;
output reg MemWrite;
output reg MemtoReg;
output reg ALUSrc;
output reg RegWrite;

/* ALUOP: 2 bits:
   00 RTYPE
   01 SW LW addi
   10 BEQ
   11 BNE 
*/

always @ (opcode)
begin
    case(opcode)
        ADD:
        begin
            ALUSrc = 0;
            ALUop = 2'b00;
            jmp = 0;
            dstReg = 1; // rd 
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            RegWrite = 1;
        end
        ADDI:
        begin
            ALUSrc = 1;
            ALUop = 2'b01;
            jmp = 0;
            dstReg = 0; // rt 
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            RegWrite = 1;
        end
        // ... (other cases remain unchanged)

        default:
        begin
            ALUSrc = 0;
            ALUop = 2'b00;
            jmp = 0;
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            dstReg = 0; // don't care  
            RegWrite = 0;
        end
    endcase
end