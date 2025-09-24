`timescale 1ns / 1ps 

module NIM_TB;
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
        $dumpfile("nim_test.vcd");
        $dumpvars(0, NIM_TB);
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

        $display("\n ***** MENYIMPAN NIM KE REGISTER ***** ");

        aluSrc = 1;
        aluCtrl = 4'b0000;
        rgr1 = 5'd0;

        // Menyimpan digit 5 di register ke-20
        immediate = 32'd5;
        rgw1 = 5'd20;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM pertama, yaitu 5 disimpan di register ke-20");

        // Menyimpan digit 2 di register ke-21
        immediate = 32'd2;
        rgw1 = 5'd21;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM kedua, yaitu 2 disimpan di register ke-21");

        // Menyimpan digit 2 di register ke-22
        immediate = 32'd2;
        rgw1 = 5'd22;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM ketiga, yaitu 2 disimpan di register ke-22");

        // Menyimpan digit 6 di register ke-23
        immediate = 32'd6;
        rgw1 = 5'd23;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM keempat, yaitu 6 disimpan di register ke-23");

        // Menyimpan digit 0 di register ke-24
        immediate = 32'd0;
        rgw1 = 5'd24;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM kelima, yaitu 2 disimpan di register ke-24");

        // Menyimpan digit 5 di register ke-20
        immediate = 32'd5;
        rgw1 = 5'd25;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM keenam, yaitu 5 disimpan di register ke-25");

        immediate = 32'd0;
        rgw1 = 5'd31;
        #10;
	regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        $display("\n ***** PENJUMALAHN DIGIT NIM ***** ");

        aluSrc = 0;
        aluCtrl = 4'b0000;

        rgr1 = 5'd31;
        rgr2 = 5'd20;
        #10;
        $display("Menjumlahkan nilai register penyimpanan (0) dengan digit pertama");
        $display("Penjumlahan digit 1: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd21;
        #10;
        $display("Menjumlahkan digit pertama dengan digit kedua");
        $display("Penjumlahan digit 2: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd22;
        #10;
        $display("Menjumlahkan hasil penjumlahan digit pertama dan kedua dengan digit ketiga");
        $display("Penjumlahan digit 3: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd23;
        #10;
        $display("Menjumlahkan hasil penjumlahan digit pertama, kedua dan ketiga dengan digit keempat");
        $display("Penjumlahan digit 4: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd24;
        #10;
        $display("Menjumlahkan hasil penjumlahan digit pertama, kedua, ketiga, dan keempat dengan digit kelima");
        $display("Penjumlahan digit 5: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd25;
        #10;
        $display("Menjumlahkan hasil penjumlahan digit pertama, kedua, ketiga, keempat, dan kelima dengan digit keenam");
        $display("Penjumlahan digit 6: %d + %d = %d", rg1data, rg2data, aluResult);

        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        rgr1 = 5'd31;
        rgr2 = 5'd0;
        #10;

        rgr1 = 5'd31;
        #60;
        $display("Hasil operasi penjumlahan digit NIU berada di register 31: %d", rg1data);

        address = 32'h0;
        #10;
        memWrite = 1;
        #10;
        memWrite = 0;

        memRead = 1;
        #10;

        $display("Hasil operasi penjumlahan digit NIU berhasil di simpan ke data memory 0: %d", memData);
        $display("Verifikasi: 5 + 2 + 2 + 6 + 0 + 5 = 20");
        $display("\n ***** SELESAI ***** ");
        $finish;
    end
endmodule