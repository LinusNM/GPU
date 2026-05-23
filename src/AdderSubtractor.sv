module AdderSubtractor (
    input  logic A, B, Cin, op, // op=0 for Add, op=1 for Sub
    output logic Cout, S
);

    // Internal signals
    logic AxB, AxBandCin, AandB;              // Adder intermediate signals
    logic BinxB, notB_andCin, notBinxB_andA; // Subtractor intermediate signals

    always_comb begin
        // 1. Calculate intermediate logic for both paths
        // Addition signals
        AxB = A ^ B;
        AxBandCin = AxB & Cin;
        AandB = A & B;

        // Subtraction signals
        BinxB = Cin ^ B;
        notB_andCin = ~B & Cin;
        notBinxB_andA = ~BinxB & A;

        // 2. Use the 'op' signal to drive the final outputs
        if (~op) begin
            // Perform Addition
            S    = AxB ^ Cin;
            Cout = AandB | AxBandCin;
        end 
        else begin
            // Perform Subtraction
            S    = BinxB ^ A;
            Cout = notB_andCin | notBinxB_andA;
        end
    end

endmodule
