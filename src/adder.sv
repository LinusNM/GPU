module adder(
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] sum
);

    assign sum = a + b; // Declaring 32-bit, unsigned addition

endmodule
