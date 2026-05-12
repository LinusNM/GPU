// This module represents 1 core equivalent to 1 block.
// THREADS_PER_BLOCK controls how many Thread instances are created at elaboration time.

module Core #(parameter THREADS_PER_BLOCK = 4) (
    input logic clk,
    input logic reset
);

    // The generate statement produces THREADS_PER_BLOCK number of Threads at compile time in a single Core block.
    // Each Thread instance is named thread_gen[0].thread_inst, thread_gen[1].thread_inst, etc.
    genvar i;
    generate
        for (i = 0; i < THREADS_PER_BLOCK; i += 1) begin : thread_gen
            Thread thread_inst (.clk(clk), .reset(reset));
        end
    endgenerate

endmodule
