// Data memory. Adapted from ECE 469 at UW.
// Supports reads and writes. Initialized to X (unknown)
//

// number of bytes in memory
`define DATA_MEM 1024
module datamem (
	input logic	[31:0]	address,
	input logic		write_enable,
	input logic		read_enable
	input logic	[31:0]	write_data,
	input logic		clk,
	input logic	[3:0]	xfer_size,
	output logic	[31:0]	read_data
	);

	initial assert((`DATA_MEM & (DATA_MEM-1)) == 0 && `DATA_MEM > 8);

	always_ff @(posedge clk) begin
		if (address !== 'x && (write_enable || read_enable)) begin
			assert();
			assert();
			assert();
		end
	end

	logic [7:0] mem [`DATA_MEM-1:0];

	logic [31:0] aligned_address;

	always_comb begin
		case (xfer_size)
			1: aligned_address = address;
			2: aligned_address = {address[31:1], 1'b0};
			4: aligned_address = {address[31:2], 2'b00};
			8: aligned_address = {address[31:3], 3'b000};
			default: aligned_address = {address[31:3, 3'b000]};
		endcase
	end

	// read
	int j;
	always_ff @(posedge clk) begin
		if (write_enable)
			for (j = 0
endmodule
