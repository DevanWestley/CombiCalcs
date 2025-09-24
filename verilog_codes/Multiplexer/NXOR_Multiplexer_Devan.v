`timescale 1ns/1ns
module mux_nxor (
    input a, b, sel,
    output y
);
    
    wire nxor_ab;
    xnor(nxor_ab, a, b);
    
    assign y = sel ? nxor_ab : 1'b0;
    
endmodule

module testb;
    reg a, b, sel;
    wire y;
    
    mux_nxor uut (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $dumpfile("test1.vcd");
        $dumpvars(); // Display GTKWave
        $monitor("a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        
        a = 0; b = 0; sel = 0;
        #10 a = 0; b = 0; sel = 1;
        #10 a = 0; b = 1; sel = 0;
        #10 a = 0; b = 1; sel = 1;
        #10 a = 1; b = 0; sel = 0;
        #10 a = 1; b = 0; sel = 1;
        #10 a = 1; b = 1; sel = 0;
        #10 a = 1; b = 1; sel = 1;
        #10 $finish;
    end
endmodule
