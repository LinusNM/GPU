// The purpose of this module is to implement a program counter (PC) that keeps track of the 
// current instruction's address in a processor.
module program_counter (
    input logic             clk,

    // 1 running/paused/reset, 0 if not running
    input logic             running,
    input logic             pause,
    input logic             reset,

    // Branch signals from the control unit
    input logic             branch_taken,
    input logic [31:0]      branch_target,

    output logic [31:0]     pc
);

    always_ff @(posedge clk) begin
        if (reset)
            pc <= 32'd0;
        else if (running && !pause) begin // Only update the PC if its running and its NOT paused
            if (branch_taken) // If a branch is taken, update the PC to the branch target's address
                pc <= branch_target;
            else
                pc <= pc + 32'd4; // Incrementing the PC by 4 to point to the next instruction 
                                  // (assuming 4-byte instructions)
        end
    end

endmodule