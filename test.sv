`timescale 1 ns /10 ps

module test (input logic	a,
				input logic		b,
				output logic	sel,
				output logic	out);
				
	// This can also just be written in one line lmao
	assign out = sel ? a : b;

endmodule
