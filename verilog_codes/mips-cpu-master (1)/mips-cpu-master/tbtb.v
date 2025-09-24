`timescale 1ns/1ps
module alu_tb;
  // ALU signals
  reg         aluSrc;
  reg  [31:0] data1; // Current sum or first operand
  reg  [31:0] data2; // Not used when aluSrc = 1
  reg  [31:0] imm;   // Immediate operand for addition
  reg  [3:0]  aluCtrl;
  wire [31:0] result;
  wire        zero;
  wire        overflow;

  // Instantiate the ALU (assumed to support add immediate when aluSrc=1 and aluCtrl=0000)
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

  // Variables for file I/O and loop
  integer file, r;
  integer value;
  integer sum; // Running sum

  // Dump waveform for GTKWave
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, alu_tb);
  end

  // Read an arbitrary amount of data from file "data.txt" and chain-add them.
  // The file should contain one number per line.
  initial begin
    // Open file for reading
    file = $fopen("data.txt", "r");
    if (!file) begin
      $display("ERROR: Cannot open data.txt");
      $finish;
    end

    // Initialize ALU for addition using immediate mode
    aluSrc  = 1;           // Use immediate operand
    aluCtrl = 4'b0000;     // ADD operation
    data1   = 32'd0;       // Start with sum = 0
    sum     = 0;

    // Loop until end-of-file
    while (!$feof(file)) begin
      // Read one integer from file
      r = $fscanf(file, "%d\n", value);
      if (r != 1) break; // Exit loop if read fails
      
      // Display the value to be added
      $display("Adding value: %d", value);
      
      // Set immediate operand to current value (converted to 32-bit)
      imm = {28'd0, value};
      
      // Wait for ALU to compute (assume propagation delay of 10ns)
      #10;
      
      // Update running sum from ALU output
      sum = result;
      data1 = result;  // Use result as next input
      
      $display("Current Sum: %d", sum);
    end

    $display("Final Sum = %d", sum);
    $fclose(file);
    $finish;
  end

endmodule
