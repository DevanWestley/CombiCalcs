`timescale 1ns/1ps
module datapath_tb;
    // Clock and reset signals
    reg clk;
    reg reset;
    
    // Instantiate the top-level datapath.
    // Change "MipsCPU" to your actual top-level module name.
    MipsCPU dut (
        .clk(clk),
        .reset(reset)
        // Connect additional ports if needed.
    );
    
    // Clock generation: 10ns period (adjust as needed)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Simulation stimulus and checks
    initial begin
        // Start simulation message
        $display("Simulation started. Applying reset...");
        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        $display("Reset de-asserted. Datapath should load immediate values into register file.");
        
        // Wait for enough time for the datapath to:
        // 1. Load immediate data (the digits of your NIM) into the register file.
        // 2. Execute addition via the ALU using the provided control signals.
        // 3. Write the result (sum) into Register File address 31 and Data Memory address 0.
        // Adjust this delay (#300) based on your design's timing.
        #300;
        
        // Optionally, display the result.
        // (Assuming internal signals are accessible; modify if necessary.)
        $display("Simulation ended. Checking results...");
        $display("Register[31] contains: %d", dut.regFile.mem[31]);
        $display("DataMemory[0] contains: %d", dut.dataMemory.mem[0]);
        
        // End simulation
        $stop;
    end
    
    // Dump waveform for GTKWave
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, datapath_tb);
    end

endmodule
