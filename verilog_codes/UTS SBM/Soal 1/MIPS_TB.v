`timescale 1ns/1ps

module MIPS_TB;
  // Deklarasi sinyal testbench untuk modul ALU
  reg         aluSrc;
  reg  [31:0] data1;
  reg  [31:0] data2;
  reg  [31:0] imm;
  reg  [3:0]  aluCtrl;
  wire [31:0] result;
  wire        zero;
  wire        overflow;

  // Instansiasi modul ALU
  alu uut (
    .aluSrc(aluSrc),
    .data1(data1),
    .data2(data2),
    .imm(imm),
    .aluCtrl(aluCtrl),
    .result(result),
    .zero(zero),
    .overflow(overflow)
  );

  // Membuat dump VCD untuk melihat waveforms di GTKWave
  initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, MIPS_TB);
  end

  // Testbench utama: urutan pengujian berbagai operasi ALU
  initial begin
    // Inisialisasi awal
    aluSrc   = 1'b0;
    data1    = 32'd0;
    data2    = 32'd0;
    imm      = 32'd0;
    aluCtrl  = 4'b0000;
    #5;  // Delay singkat untuk memastikan sinyal stabil

    // =========================================================================
    // 1. Penjumlahan (Addition)
    // -------------------------------------------------------------------------
    // a. Menggunakan operand kedua dari data2 (desimal)
    // Operasi: 3 + 5 = 8
    aluSrc  = 0;
    data1   = 32'd3;
    data2   = 32'd5;
    imm     = 32'd0;  // Tidak digunakan karena aluSrc = 0
    aluCtrl = 4'b0000;  // ADD
    #10;
    $display("Addition (Decimal, data2): %d + %d = %d  [Expected: 8]", data1, data2, result);

    // b. Menggunakan immediate operand (desimal)
    // Operasi: 7 + 9 = 16
    aluSrc  = 1;
    data1   = 32'd7;
    imm     = 32'd9;
    aluCtrl = 4'b0000;  // ADD
    #10;
    $display("Addition (Decimal, Immediate): %d + %d = %d  [Expected: 16]", data1, imm, result);

    // c. Menggunakan nilai heksadesimal
    // Operasi: 0x0A + 0x05 = 0x0F (10 + 5 = 15)
    aluSrc  = 0;
    data1   = 32'h0A;
    data2   = 32'h05;
    imm     = 32'd0;
    aluCtrl = 4'b0000;  // ADD
    #10;
    $display("Addition (Hex): 0x%h + 0x%h = 0x%h  [Expected: 0x0F]", data1, data2, result);

    // =========================================================================
    // 2. Pengurangan (Subtraction)
    // -------------------------------------------------------------------------
    // a. Subtraction dengan nilai desimal
    // Operasi: 15 - 5 = 10
    aluSrc  = 0;
    data1   = 32'd15;
    data2   = 32'd5;
    imm     = 32'd0;
    aluCtrl = 4'b0010;  // SUB
    #10;
    $display("Subtraction (Decimal): %d - %d = %d  [Expected: 10]", data1, data2, result);

    // b. Subtraction dengan nilai heksadesimal
    // Operasi: 0x1E - 0x0A = 0x14 (30 - 10 = 20)
    aluSrc  = 0;
    data1   = 32'h1E;
    data2   = 32'h0A;
    imm     = 32'd0;
    aluCtrl = 4'b0010;  // SUB
    #10;
    $display("Subtraction (Hex): 0x%h - 0x%h = 0x%h  [Expected: 0x14]", data1, data2, result);

    // =========================================================================
    // 3. Operasi Logika (AND dan OR)
    // -------------------------------------------------------------------------
    // a. AND dengan nilai heksadesimal
    // Operasi: 0xF0F0F0F1 & 0x0F0F0F0F = 0x00000001
    aluSrc  = 0;
    data1   = 32'hF0F0F0F1;
    data2   = 32'h0F0F0F0F;
    imm     = 32'd0;
    aluCtrl = 4'b0100;  // AND
    #10;
    $display("AND: 0x%h & 0x%h = 0x%h  [Expected: 0x00000001]", data1, data2, result);

    // b. OR dengan nilai heksadesimal
    // Operasi: 0xF0F0F0F1 | 0x0F0F0F0F = 0xFFFFFFFF
    aluSrc  = 0;
    data1   = 32'hF0F0F0F1;
    data2   = 32'h0F0F0F0F;
    imm     = 32'd0;
    aluCtrl = 4'b0101;  // OR
    #10;
    $display("OR: 0x%h | 0x%h = 0x%h  [Expected: 0xFFFFFFFF]", data1, data2, result);

    // =========================================================================
    // 4. Operasi Shift
    // -------------------------------------------------------------------------
    // a. Shift Left Logical (SLL)
    // Operasi: 1 << 3 = 8
    aluSrc  = 0;
    data1   = 32'd1;
    data2   = 32'd3;  // Jumlah bit shift
    imm     = 32'd0;
    aluCtrl = 4'b0110;  // SLL
    #10;
    $display("SLL: %d << %d = %d  [Expected: 8]", data1, data2, result);

    // b. Shift Right Logical (SRL)
    // Operasi: 8 >> 2 = 2
    aluSrc  = 0;
    data1   = 32'd8;
    data2   = 32'd2;  // Jumlah bit shift
    imm     = 32'd0;
    aluCtrl = 4'b0111;  // SRL
    #10;
    $display("SRL: %d >> %d = %d  [Expected: 2]", data1, data2, result);

    // =========================================================================
    // 5. Set Less Than (SLT)
    // -------------------------------------------------------------------------
    // a. Kondisi benar: jika data1 < data2
    // Operasi: 3 < 5 => result = 1
    aluSrc  = 0;
    data1   = 32'd3;
    data2   = 32'd5;
    imm     = 32'd0;
    aluCtrl = 4'b1000;  // SLT
    #10;
    $display("SLT (True): %d < %d = %d  [Expected: 1]", data1, data2, result);

    // b. Kondisi salah: jika data1 >= data2
    // Operasi: 5 < 3 => result = 0
    aluSrc  = 0;
    data1   = 32'd5;
    data2   = 32'd3;
    imm     = 32'd0;
    aluCtrl = 4'b1000;  // SLT
    #10;
    $display("SLT (False): %d < %d = %d  [Expected: 0]", data1, data2, result);

    // =========================================================================
    // 6. Branch Conditions: BEQ dan BNE
    // -------------------------------------------------------------------------
    // a. BEQ (Branch if Equal) - kondisi benar
    // Operasi: 10 == 10, maka result = 1
    aluSrc  = 0;
    data1   = 32'd10;
    data2   = 32'd10;
    imm     = 32'd0;
    aluCtrl = 4'b1001;  // BEQ
    #10;
    $display("BEQ (Equal): %d == %d, result = %d  [Expected: 1]", data1, data2, result);

    // b. BEQ (Branch if Equal) - kondisi salah
    // Operasi: 10 != 20, maka result = 0
    aluSrc  = 0;
    data1   = 32'd10;
    data2   = 32'd20;
    imm     = 32'd0;
    aluCtrl = 4'b1001;  // BEQ
    #10;
    $display("BEQ (Not Equal): %d == %d, result = %d  [Expected: 0]", data1, data2, result);

    // c. BNE (Branch if Not Equal) - kondisi benar
    // Operasi: 10 != 20, maka result = 1
    aluSrc  = 0;
    data1   = 32'd10;
    data2   = 32'd20;
    imm     = 32'd0;
    aluCtrl = 4'b1010;  // BNE
    #10;
    $display("BNE (Not Equal): %d != %d, result = %d  [Expected: 1]", data1, data2, result);

    // d. BNE (Branch if Not Equal) - kondisi salah
    // Operasi: 10 == 10, maka result = 0
    aluSrc  = 0;
    data1   = 32'd10;
    data2   = 32'd10;
    imm     = 32'd0;
    aluCtrl = 4'b1010;  // BNE
    #10;
    $display("BNE (Equal): %d != %d, result = %d  [Expected: 0]", data1, data2, result);

    // =========================================================================
    // 7. Pengujian Kompleks: Penjumlahan dua nilai heksadesimal besar
    // -------------------------------------------------------------------------
    // Operasi: 0xFFAA123E + 0xDD1111B1
    // Perhitungan:
    //   0xFFAA123E + 0xDD1111B1 = 0x1DCBB23EF (9-digit hasil)
    // Karena ALU 32-bit hanya menggunakan 32-bit bagian rendah:
    //   Lower 32-bit = 0xDCBB23EF
    // Overflow (carry out) diharapkan = 1.
    aluSrc  = 0;
    data1   = 32'hFFAA123E;
    data2   = 32'hDD1111B1;
    imm     = 32'd0;
    aluCtrl = 4'b0000;  // ADD
    #10;
    $display("Complex Hex Addition: 0x%h + 0x%h = 0x%h, Overflow = %b  [Expected: 0xDCBB23EF, Overflow = 1]", 
             data1, data2, result, overflow);

    $finish;
  end

endmodule
