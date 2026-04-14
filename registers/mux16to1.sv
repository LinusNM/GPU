// 16-to-1 Multiplexer
module mux16to1 (
    input  logic [15:0] in,  
    input  logic [3:0]  sel, 
    output logic        out    
);
    
    // The index 'sel' automatically selects the correct bit from 'in'
    assign out = in[sel];

endmodule