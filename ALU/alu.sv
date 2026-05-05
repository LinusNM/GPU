module alu (A, B, sum, Cout)

    input logic A, B;
    output logic sum, Cout;

    xor(sum, A, B);
    and(Cout, A, B);

    genvar i;

    generate begin
        
        for(i=o; i <32; i++) begin
            
            // placeholder

        end

    end

endmodule
