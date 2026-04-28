module alu_mux(
    input  logic [1:0]  sel,
    input  logic [31:0] add_result,
    input  logic [31:0] and_result,
    input  logic [31:0] or_result,
    input  logic [31:0] xor_result,
    output logic [31:0] alu_out
);

    always_comb begin
        case (sel)
            2'b00: alu_out = add_result;
            2'b01: alu_out = and_result;
            2'b10: alu_out = or_result;
            2'b11: alu_out = xor_result;
        endcase
    end

endmodule
