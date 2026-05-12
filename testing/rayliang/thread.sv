module thread (
    input logic clk,
    input logic reset,
    input logic pause,
    input logic running,



    //alu
    input logic [1:0] sel,
    input  logic [31:0] add_result,
    input  logic [31:0] and_result,
    input  logic [31:0] or_result,
    input  logic [31:0] xor_result,
    output logic [31:0] alu_out

    // register


    input  logic        clk,            
    input  logic        reset,          // Synchronous (active-high) reset
    input  logic [3:0]  write_address,  // 4-bit address to select the write register
    input  logic [31:0] write_data,     // 32-bit data to be written
    input  logic        write_enable,   // Write enable control signal
    
    input  logic [3:0]  read_address_1, // Port 1: 4-bit address to read
    output logic [31:0] read_data_1,    // Port 1: 32-bit data output
    
    input  logic [3:0]  read_address_2, // Port 2: 4-bit address to read
    output logic [31:0] read_data_2     // Port 2: 32-bit data output

    // program counter 

     input logic             clk, 

    input logic             running,
    input logic             pause,
    input logic             reset,

    // If the ALU passed in 
    input logic             branch_taken,
    input logic [31:0]      branch_data,

    output logic [31:0]     pc
);
    

// 









alu_mux u_alu_mux (
    .sel (sel),
    .add_result (add_result),
    .and_result (and_result),
    .or_result (or_result),
    .xor_result (xor_result),
    .alu_out (alu_out)
);

// register

regfile u_regfile (
    .clk (clk),
    .reset (reset),
    .write_address (write_address),
    .write_data (alu_out),
    .write_enable   (write_enable),
    .read_address_1 (read_address_1),
    .read_data_1    (read_data_1),
    .read_address_2 (read_address_2),
    .read_data_2    (read_data_2)
);

// program counter

program_counter u_program_counter (
    .clk (clk),
    .running      (running),
    .pause        (pause),
    .reset        (reset),
    .branch_taken (branch_taken),
    .branch_data  (branch_data),
    .pc           (pc)
);

// LSU 

LSU u_LSU (

);

endmodule