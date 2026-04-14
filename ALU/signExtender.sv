module signExtender (
    parameter N,
    input logic [N-1:0] data_in,
    output logic [31:0] data_out
);

    // Concatenate 32-N copies of the sign bit to the most significant bits (MSBs) 
    // and the input signal to the least significant bits (LSBs)
    assign data_out = {{(32-N){data_in[N-1]}}, data_in};

endmodule // signExtender
