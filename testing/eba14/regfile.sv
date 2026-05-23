// Register file with 16 entries, each 32 bits wide.
// Structurally built using decoder (write port) and mux16to1 (read ports)
// as submodules to reflect actual gate-level hardware.
//
// Write path: write_address -> decoder -> one-hot write enable per register -> DFFs
// Read path:  all 32-bit registers -> 32x mux16to1 (one per bit) -> read_data
module RegFile (
    input  logic        clk,
    input  logic        reset,
    input  logic [3:0]  write_address,
    input  logic [31:0] write_data,
    input  logic        write_enable,

    input  logic [3:0]  read_address_1,
    output logic [31:0] read_data_1,

    input  logic [3:0]  read_address_2,
    output logic [31:0] read_data_2
);

    // One-hot write enable: only the selected register's bit is high
    logic [15:0] write_select;

    decoder write_decoder (
        .in    (write_address),
        .enable(write_enable),
        .out   (write_select)
    );

    // 16 registers, each 32 bits wide
    logic [31:0] registers [0:15];

    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 16; i++)
                registers[i] <= 32'b0;
        end 
        else begin
            for (int i = 0; i < 16; i++)
                if (write_select[i])
                    registers[i] <= write_data;
        end
    end

    // Read port 1: 32 mux16to1 instances, one per bit
    genvar b;
    generate
        for (b = 0; b < 32; b++) begin : read1_mux
            // Collect bit 'b' from all 16 registers into a 16-bit bus
            logic [15:0] bit_bus_1;
            assign bit_bus_1 = {
                registers[15][b], registers[14][b], registers[13][b], registers[12][b],
                registers[11][b], registers[10][b], registers[9][b],  registers[8][b],
                registers[7][b],  registers[6][b],  registers[5][b],  registers[4][b],
                registers[3][b],  registers[2][b],  registers[1][b],  registers[0][b]
            };

            mux16to1 mux1 (
                .in (bit_bus_1),
                .sel(read_address_1),
                .out(read_data_1[b])
            );
        end
    endgenerate

    // Read port 2: 32 mux16to1 instances, one per bit
    generate
        for (b = 0; b < 32; b++) begin : read2_mux
            logic [15:0] bit_bus_2;
            assign bit_bus_2 = {
                registers[15][b], registers[14][b], registers[13][b], registers[12][b],
                registers[11][b], registers[10][b], registers[9][b],  registers[8][b],
                registers[7][b],  registers[6][b],  registers[5][b],  registers[4][b],
                registers[3][b],  registers[2][b],  registers[1][b],  registers[0][b]
            };

            mux16to1 mux2 (
                .in (bit_bus_2),
                .sel(read_address_2),
                .out(read_data_2[b])
            );
        end
    endgenerate

endmodule
