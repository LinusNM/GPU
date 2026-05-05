module additiveOperation (A, B, connectIn, connectOut, S, operation)

    // when operation is 0, perform addition; when operation is 1, perform subtraction
    input logic A, B, connectIn, operation;
    output logic connectOut, S;

    // intermediate signals for full adder
    logic AxorB, AandB, AxorBandconnectIn;

    if (!operation) begin

    // logic for full adder
    assign AxorB = A ^ B;
    assign AandB = A & B;
    assign AxorBandconnectIn = AxorB & connectIn;
    assign S = AxorB ^ connectIn;
    assign connectOut = AandB | AxorBandconnectIn;
    
    end // addition logic

    else begin

    end // subtraction logic 

endmodule