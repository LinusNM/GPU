// This is the top level module that integrates all of the cores, control,
// dispatch, and memory controllers within the GPU.

module GPU #(parameter NUM_CORES = 4, parameter THREADS_PER_BLOCK = 4) (
    input logic clk,
    input logic reset
);

    // generate expands this loop before simulation runs (called elaboration time), so the
    // tool reads the parameters, counts how many instances to create, and locks in the
    // hardware structure. NUM_CORES Core instances are created, each with THREADS_PER_BLOCK
    // threads, named core_gen[0].core_inst, core_gen[1].core_inst, etc.
    genvar i;
    generate
        for (i = 0; i < NUM_CORES; i += 1) begin : core_gen
            Core #(.THREADS_PER_BLOCK(THREADS_PER_BLOCK)) core_inst (
                .clk  (clk),
                .reset(reset)
            );
        end
    endgenerate

    // Additional modules (control/dispatch, memory interconnect) would be
    // instantiated here and connected accordingly.

endmodule
