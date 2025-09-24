`timescale 1ns / 1ps 

module NIM_TB;
    // Input signals
    reg [4:0] rgr1, rgr2, rgw1;
    reg [31:0] immediate;
    reg [31:0] address;
    reg memWrite, memRead;
    reg aluSrc, regWrite;
    reg [3:0] aluCtrl;

    // Output signals
    wire [31:0] rg1data, rg2data;
    wire [31:0] aluResult;
    wire zero, overflow;
    wire [31:0] memData;

    // Instantiate register file (check that the module in your file is named regsFile)
    regsFile rf (
        .rgr1(rgr1),
        .rgr2(rgr2),
        .write(regWrite),
        .rgw1(rgw1),
        .rgw1data(aluResult),
        .rg1data(rg1data),
        .rg2data(rg2data)
    );

    // Instantiate ALU (if your ALU module is named alu in your source, use alu)
    alu alu_unit (
        .aluSrc(aluSrc),
        .data1(rg1data),
        .data2(rg2data),
        .imm(immediate),
        .aluCtrl(aluCtrl),
        .result(aluResult),
        .zero(zero),
        .overflow(overflow)
    );

    // Instantiate data memory (if the module name is dataMem in your file)
    dataMem dm (
        .address(address),
        .writeData(aluResult),
        .readData(memData),
        .memWrite(memWrite),
        .memRead(memRead)
    );
    
    // Dump the simulation waveform for debugging
    initial begin
        $dumpfile("nim_test.vcd");
        $dumpvars(0, NIM_TB);
    end

    // Test stimulus
    initial begin
        // Initialize signals
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

        // Store first digit (5) into register 20
        aluSrc = 1;
        aluCtrl = 4'b0000; // assume ALU performs addition with immediate value
        rgr1 = 5'd0;
        immediate = 32'd5;
        rgw1 = 5'd20;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM pertama, yaitu 5 disimpan di register ke-20");

        // Store second digit (2) into register 21
        immediate = 32'd2;
        rgw1 = 5'd21;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM kedua, yaitu 2 disimpan di register ke-21");

        // Store third digit (2) into register 22
        immediate = 32'd2;
        rgw1 = 5'd22;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM ketiga, yaitu 2 disimpan di register ke-22");

        // Store fourth digit (4) into register 23
        immediate = 32'd4;
        rgw1 = 5'd23;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM keempat, yaitu 4 disimpan di register ke-23");

        // Store fifth digit (7) into register 24
        immediate = 32'd7;
        rgw1 = 5'd24;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM kelima, yaitu 7 disimpan di register ke-24");

        // Store sixth digit (9) into register 25
        immediate = 32'd9;
        rgw1 = 5'd25;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;
        $display("Digit NIM keenam, yaitu 9 disimpan di register ke-25");

        // Initialize accumulator (register 31) to 0 for addition
        immediate = 32'd0;
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        $display("\n ***** PENJUMLAHAN DIGIT NIM ***** ");

        aluSrc = 0;       // use register outputs
        aluCtrl = 4'b0000;// assume addition operation

        // Add first digit: 0 + value from register 20
        rgr1 = 5'd31;
        rgr2 = 5'd20;
        #10;
        $display("Penjumlahan digit 1: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Add second digit: current sum + register 21
        rgr1 = 5'd31;
        rgr2 = 5'd21;
        #10;
        $display("Penjumlahan digit 2: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Add third digit: current sum + register 22
        rgr1 = 5'd31;
        rgr2 = 5'd22;
        #10;
        $display("Penjumlahan digit 3: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Add fourth digit: current sum + register 23
        rgr1 = 5'd31;
        rgr2 = 5'd23;
        #10;
        $display("Penjumlahan digit 4: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Add fifth digit: current sum + register 24
        rgr1 = 5'd31;
        rgr2 = 5'd24;
        #10;
        $display("Penjumlahan digit 5: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Add sixth digit: current sum + register 25
        rgr1 = 5'd31;
        rgr2 = 5'd25;
        #10;
        $display("Penjumlahan digit 6: %d + %d = %d", rg1data, rg2data, aluResult);
        rgw1 = 5'd31;
        #10;
        regWrite = 1;
        #10;
        regWrite = 0;
        #10;

        // Final result in register 31 should now be the sum
        rgr1 = 5'd31;
        #60;
        $display("Hasil penjumlahan digit NIM di register 31: %d", rg1data);

        // Write final result into data memory at address 0
        address = 32'h0;
        #10;
        memWrite = 1;
        #10;
        memWrite = 0;
        
        // Read the memory location back
        memRead = 1;
        #10;
        $display("Nilai di data memory address 0: %d", memData);
        $display("Verifikasi: 5 + 2 + 2 + 4 + 7 + 9 = 29");
        $display("\n ***** SELESAI ***** ");
        $finish;
    end
endmodule
