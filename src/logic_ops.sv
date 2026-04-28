module logic_ops(
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] and_result,
    output logic [31:0] or_result,
    output logic [31:0] xor_result
);

    assign and_result = a & b;
    assign or_result  = a | b;
    assign xor_result = a ^ b;

endmodule
