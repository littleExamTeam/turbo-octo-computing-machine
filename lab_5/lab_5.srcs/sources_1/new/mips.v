`timescale 1ns / 1ps
module mips(
    input wire clk, rst,

    output wire [31:0] PCF,
    input  wire [31:0] InstF,

    output wire MemWriteM,
    output wire [31:0] ALUOutM,
    output wire [31:0] WriteDataM,
    input  wire [31:0] ReadDataM
);

wire JumpD;
wire RegWriteD;
wire MemtoRegD;
wire MemWriteD;
wire [7:0] ALUContrD;
wire [1:0] ALUSrcD;
wire RegDstD;
wire BranchD;

wire [5:0] Op;
wire [5:0] Funct;

controller c(
    Op, Funct,
    JumpD, RegWriteD, RegDstD, ALUSrcD, BranchD, MemWriteD, MemtoRegD,
    ALUContrD
);

datapath dp(
    clk, rst,

    PCF, InstF,
    
    Op, Funct,
    RegWriteD,
    MemtoRegD,
    MemWriteD,
    ALUContrD,
    ALUSrcD,
    RegDstD,
    JumpD,
    BranchD,
    

    MemWriteM,
    ALUOutM,
    WriteDataM,
    ReadDataM
);

endmodule