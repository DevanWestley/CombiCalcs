`ifndef MIPS_H
`define MIPS_H

`define WORD_SIZE 32

`define ZERO  5'b00000  // $zero
`define V0    5'b00010  // $v0
`define A0    5'b00100  // $a0
`define T0    5'b01000  // $t0
`define T1    5'b01001  // $t1
`define SP    5'b11101  // $sp
`define RA    5'b11111  // $ra

`define OP_ADD  6'b100000  // ADD
`define OP_SUB  6'b100010  // SUB
`define OP_AND  6'b100100  // AND
`define OP_OR   6'b100101  // OR
`define OP_XOR  6'b100110  // XOR

`endif
