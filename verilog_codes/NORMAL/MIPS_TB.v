`timescale 1ns / 1ps 

module MIPS_TB;
    reg [4:0] rgr1, rgr2, rgw1;
    reg [31:0] immediate;
    reg [31:0] address;
    reg memWrite, memRead;
    reg aluSrc, regWrite;
    reg [3:0] aluCtrl;

    wire [31:0] rg1data, rg2data;
    wire [31:0] aluResult;
    wire zero, overflow;
    wire [31:0] memData;

    regsFile rf(
        .rgr1(rgr1),
        .rgr2(rgr2),
        .write(regWrite),
        .rgw1(rgw1),
        .rgw1data(aluResult),
        .rg1data(rg1data),
        .rg2data(rg2data)
    );

    alu alu_unit(
        .aluSrc(aluSrc),
        .data1(rg1data),
        .data2(rg2data),
        .imm(immediate),
        .aluCtrl(aluCtrl),
        .result(aluResult),
        .zero(zero),
        .overflow(overflow)
    );

    dataMem dm(
        .address(address),
        .writeData(aluResult),
        .readData(memData),
        .memWrite(memWrite),
        .memRead(memRead)
    );

    initial begin
        $dumpfile("mips_test.vcd");
        $dumpvars(0, MIPS_TB);
    end

    initial begin
        rgr1 = 0;
        rgr2 = 0;
        rgw1 = 0;
        immediate = 0;
        address = 0;
        memWrite = 0;
        memRead = 0;
        aluSrc = 0;
        regWrite = 0;
        aluCtrl = 0;

        #10;

        $display("\n ***** TES OPERASI ADD ***** ");

        rgr1 = 5'd1;
        rgr2 = 5'd2;
        aluSrc = 0;
        aluCtrl = 4'b0000;

        #10;

        $display("ADD: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd10;
        #5;
	regWrite = 1;
        #5;
        regWrite = 0;

        rgr1 = 5'd10;
        #10;
        $display("Hasil operasi disimpan di register ke-10: %d", rg1data);

        $display("\n ***** TES OPERASI OR ***** ");

        rgr1 = 5'd4;
        immediate = 32'h00000001;
        aluSrc = 1;
        aluCtrl = 4'b0101;

        #10;
        $display("OR: %h | %h = %h", rg1data, immediate, aluResult);

        rgw1 = 5'd11;
        #5;
	regWrite = 1;
        #5;
        regWrite = 0;

        rgr1 = 5'd11;
        #10;
        $display("Hasil operasi disimpan di register ke-11: %h", rg1data);

        $display("\n ***** TES OPERASI ADD MENGGUNAKAN HASIL SEBELUMNYA ***** ");

        rgr1 = 5'd10;
        rgr2 = 5'd11;
        aluSrc = 0;
        aluCtrl = 4'b0000;

        #10;
        $display("PREVIOUS: Register 10(%d) + Register11(%h) = %h", rg1data, rg2data, aluResult);

        rgw1 = 5'd25;
        #5;
	regWrite = 1;
        #5;
        regWrite = 0;

        rgr1 = 5'd25;
        #10;
        $display("Hasil operasi disimpan di register ke-25: %h", rg1data);
        $display("\n ***** SELESAI ***** ");
        $finish;
    end
endmodule