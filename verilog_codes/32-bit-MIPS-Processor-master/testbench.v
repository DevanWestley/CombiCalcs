module mips_testbench ();

	reg clock;
	reg reset;
	wire [31:0] result;

	// Instantiate MIPS Core
	mips_core test (
		.clock(clock),
		.reset(reset),
		.result(result)
	);

	// Instantiate Full Adder 32-bit
	wire [31:0] a, b, sum;
	wire carry_in, carry_out;
	fulladder32bit fa32 (
		.a(a),
		.b(b),
		.carry_in(carry_in),
		.sum(sum),
		.carry_out(carry_out)
	);

	// Clock Generation
	always #25 clock = ~clock;

	initial begin 
		clock = 0;
		reset = 1;
		#50 reset = 0;
		
		// Test input values
		a = 32'hA5A5A5A5;
		b = 32'h5A5A5A5A;
		carry_in = 0;

		#100;
		$stop;
	end

endmodule
