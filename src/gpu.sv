module gpu(
    input logic clk,
    input logic rst_n, // reset active low
    input logic start,
    input logic we, // write enable
    input logic [31:0] write_data,
    input logic [31:0] address,

    output logic [31:0] read_data,
    output logic busy,
    output logic done

);

    localparam int NUM_REGS = 16;
    localparam int ADDR_WIDTH = 32;
    localparam int INSTR_WIDTH = 16;

    // For the control signals
    logic compute_start;
    logic compute_done;
    logic alu_we;

    // For the register file
    logic [31:0] reg_wdata, reg_rdata1, reg_rdata2; // Since data is 32 bits
    logic [3:0] reg_waddr, reg_raddr1, reg_raddr2; // Since we have 16 registers
    logic reg_we;

    // TODO: Once the thread file is done, we can add the thread file 
    // instances here so then we can remove the adder logic ops regs etc.

    // For the ALU unit
    logic [31:0] alu_a;
    logic [31:0] alu_b;
    logic [31:0] alu_sum;
    logic [31:0] alu_and;
    logic [31:0] alu_or;
    logic [31:0] alu_xor;

    // For the ALU unit
    adder adder_inst (
        .a(alu_a),
        .b(alu_b),
        .sum(alu_sum)
    );

    logic_ops logic_ops_inst (
        .a(alu_a),
        .b(alu_b),
        .and_result(alu_and),
        .or_result(alu_or),
        .xor_result(alu_xor)
    );

    // Register file instance
    regfile regfile_inst (
        .clk(clk),
        .rst_n(rst_n),
        .we(reg_we),
        .waddr(reg_waddr),
        .wdata(reg_wdata),
        .raddr1(reg_raddr1),
        .rdata1(reg_rdata1),
        .raddr2(reg_raddr2),
        .rdata2(reg_rdata2)
    );

    // Program counter instance
    program_counter pc_inst (
        .clk(clk),
        .running(compute_start),
        .pause(1'b0),
        .reset(~rst_n), // Invert since the reset is active low
        .branch_taken(1'b0),
        .branch_data(32'd0),
        .pc()
    );

    assign busy = compute_start && !compute_done;
    assign done = compute_done;

endmodule

