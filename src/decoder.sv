// This module takes a 4-bit input and produces a 16-bit one-hot output (decoder), 
// where only the bit corresponding to the input value is set to 1, and all other bits are 0. 
// The output is only active when the enable signal is high (ENABLED decoder).
module decoder (
    input  logic [3:0]  in,
    input  logic        enable,
    output logic [15:0] out
);

    always_comb begin
        out = 16'b0;          // Default: All bits 0 (not enabled)
        if (enable) begin
            out[in] = 1'b1;   // Direct indexing: Set ONLY the bit at position 'in' as '1'
        end
    end
endmodule
