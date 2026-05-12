module ALU (input1, input2, input3, output1, output2, operation);

    input logic [31:0] input1, input2, input3;
    input logic [2:0] operation;

    output logic [31:0] output1, output2;

    always_comb begin
        
        case (operation) begin
            
            // addition
            3'b000: AdderSubtractor ADD (.A(input1), .B(input2), .Cin(input3), 
            .S(output1), .Cout(output2), .op(1'b0));

            // subtraction
            3'b001: AdderSubtractor SUB (.A(input1), .B(input2), .Cin(input3), 
            .S(output1), .Cout(output2), .op(1'b1));

            // sign extention
            3'b010: signExtender #(.N($bits(input1))) SIGN (.data_in(input1), .data_out(output1));

            // zero extention
            3'b011: zeroExtender #(.N($bits(input1))) ZERO (.data_in(input1), .data_out(output1));

            // multiplication
            3'b100: MultiplyDivide MULTIP (.A(input1), .B(input2), .op(1'b0), .result({output2, output1}));

            // division
            3'b101: MultiplyDivide DIVIDE (.A(input1), .B(input2), .op(1'b1), .result({output2, output1}));

            default: ; // do nothing

        end // endcase

    end // always_comb

endmodule // ALU