// This module implements a register file with 16 entries, each 32 bits wide.
// It provides a single write port and two read ports.
// Writing is synchronous to the rising edge of 'clk' when 'write_enable' is active.
// Reading is combinational, which is used to provide the data at 'read_address'.
// The 'reset' signal is used to clear all registers to a value of 0.
module regfile (
    input  logic        clk,            // System clock
    input  logic        reset,          // Synchronous (active-high) reset
    input  logic [3:0]  write_address,  // 4-bit address to select the write register
    input  logic [31:0] write_data,     // 32-bit data to be written
    input  logic        write_enable,   // Write enable control signal
    
    input  logic [3:0]  read_address_1, // Port 1: 4-bit address to read
    output logic [31:0] read_data_1,    // Port 1: 32-bit data output
    
    input  logic [3:0]  read_address_2, // Port 2: 4-bit address to read
    output logic [31:0] read_data_2     // Port 2: 32-bit data output
);

    // Internal storage array: 16 registers (unpacked), each 32 bits wide (packed).
    logic [31:0] register_storage [0:15];

    // WRITE Logic (Sequential)
    // This logic handles updating the register values.
    always_ff @(posedge clk) begin
        if (reset) begin
            // Clear all registers to zero
            for (int i = 0; i < 16; i++) begin
                register_storage[i] <= 32'b0;
            end
        end 
        else if (write_enable) begin
            // Store the write_data into the selected register
            register_storage[write_address] <= write_data;
        end
    end

    // READ Logic (Combinational)
    // This behaves like the 16-to-1 MUX, selecting a register to output.
    assign read_data_1 = register_storage[read_address_1];
    assign read_data_2 = register_storage[read_address_2];

endmodule
