module zeroExtender (
    parameter N,
    input logic [N-1:0] data_in,
    output logic [31:0] data_out
);

    // Concatenate 32-N zeros to the most significant bits (MSBs) 
    // and the input signal to the least significant bits (LSBs)
    assign data_out = {{(32-N){1'b0}}, data_in};

endmodule // zeroExtender
