`timescale 10ns/1ns
module cpu_TB;

reg clk, reset;
reg memOpDone;
wire [31:0] dataBus;

wire [31:0] addressBus;
wire memRWPin;

reg [31:0] MemData;

/* Instance */
cpu MipsCpu( // cpu input/output pins
    .dataBus(dataBus),
    .clk(clk), 
    .reset(reset),
    .memRWPin(memRWPin), // 1: write, 0: read
    .memOpDone(memOpDone),
    .addressBus(addressBus)
);

assign dataBus = memRWPin ? 32'bz : MemData;

/* Initializing inputs */
initial begin 
    clk = 0;
    reset = 1;
end 

/* Generate VCD dump for GTKWave */
initial begin
  $dumpfile("cpu_tb.vcd");  // VCD file name
  $dumpvars(0, cpu_TB);     // Dump all variables in cpu_TB and below
end

/* Monitor values */
initial begin 
    $display ("\t\ttime,\tPC,\tstage");
    $monitor ("%d, %d, %d", $time, MipsCpu.pc, MipsCpu.stage);
end

// Generate clock 
always 
  #1 clk = ~clk;

event reset_done;
/* Generating input values */
task rst();
  begin
    @(negedge clk);
      reset = 0;
    #5;
    @(negedge clk);
      begin 
        reset = 1;
        ->reset_done;
      end
  end 
endtask

initial begin 
    #1 rst();
end

always @(posedge clk) begin 
    #1;
    if(memRWPin == 1'b1) begin
        /* Write from CPU to memory */
        #1;
        $display ("Memory Access TO address: %d , data: %d", addressBus, dataBus);
        MemData <= dataBus;
        #1;
        memOpDone <= 1'b1;
        #3;
        memOpDone <= 1'b0;
    end
    else if(memRWPin == 1'b0) begin
        /* Write from memory to CPU */
        #1;
        $display ("Memory Access FROM address:%d , data: %d", addressBus, dataBus);
        memOpDone <= 1'b1;
        #3;
        memOpDone <= 1'b0;
    end
end

initial begin 
    @(reset_done) begin
        #500; // Wait for a while to let instructions run
        $stop;
    end
end 

endmodule
