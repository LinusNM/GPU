// This module supports ADD, SUB, MUL, DIV (signed).
// Flags: overflow, negative, carry_out, zero.

module ALU (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [1:0]  operation,        // 00=ADD, 01=SUB, 10=MUL, 11=DIV
    output logic [31:0] result,
    output logic        overflow,
    output logic        negative,
    output logic        carry_out,
    output logic        zero
);

    // 33-bit wide so the extra bit[32] naturally holds the carry/borrow after ADD or SUB.
    // Prepending 1'b0 to each 32-bit operand ({1'b0, a}) zero-extends them to 33 bits,
    // so the arithmetic result overflows into bit[32] instead of being lost.
    logic [32:0]        add_sub_result;
    logic signed [63:0] mul_full; // 64-bit to capture full signed MUL product

    always_comb begin
        result    = 32'b0;
        overflow  = 1'b0;
        carry_out = 1'b0;
        add_sub_result = 33'b0;
        mul_full  = 64'b0;

        case (operation)
            2'b00: begin // ADD
                add_sub_result = {1'b0, a} + {1'b0, b};
                result    = add_sub_result[31:0];
                carry_out = add_sub_result[32];
                // Signed overflow: two positives sum to negative, or two negatives sum to positive
                overflow  = (~a[31] & ~b[31] & result[31]) |
                            ( a[31] &  b[31] & ~result[31]);
            end

            2'b01: begin // SUB
                add_sub_result = {1'b0, a} - {1'b0, b};
                result    = add_sub_result[31:0];
                carry_out = add_sub_result[32]; // borrow out
                // Signed overflow: positive - negative = negative, or negative - positive = positive
                overflow  = ( a[31] & ~b[31] & ~result[31]) |
                            (~a[31] &  b[31] &  result[31]);
            end

            2'b10: begin // MUL (signed, lower 32 bits returned)
                // $signed() tells SystemVerilog to treat the variable's bits as a signed (two's complement)
                // value for this operation. Without it, a and b would be treated as unsigned by default.
                mul_full = $signed(a) * $signed(b);
                result   = mul_full[31:0];
                // Overflow if the upper 32 bits are not just sign-extension of bit 31
                overflow = (mul_full[63:32] != {32{mul_full[31]}});
            end

            2'b11: begin // DIV (signed, guarded against divide-by-zero)
                if (b == 32'b0) begin
                    result   = 32'b0;
                    overflow = 1'b1; // divide by zero
                end 
                else begin
                    result = $signed(a) / $signed(b);
                end
            end
        endcase

        negative = result[31];
        zero     = (result == 32'b0);
    end

endmodule
