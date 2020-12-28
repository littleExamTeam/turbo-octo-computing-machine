`timescale 1ns / 1ps
`include "defines.vh"

module main_dec(
    input wire [5:0] op,
    output wire jump, regwrite, regdst, alusrc, branch, memwrite, memtoreg,
    output wire [1:0] aluop
);

reg [6:0] signals;
reg [1:0] aluop_reg;

assign {jump, regwrite, regdst, alusrc, branch, memwrite, memtoreg} = signals;
assign aluop = aluop_reg;

always @(op) begin
    case(op)
        6'b000000: begin    //R-type
        signals <= 7'b0110000;
        aluop_reg <= 2'b10;
    end
        6'b100011: begin    //lw
        signals <= 7'b0101001;
        aluop_reg <= 2'b00;
    end
        6'b101011: begin    //sw
        signals <= 7'b0001010;
        aluop_reg <= 2'b00;
    end
        6'b000100: begin    //beq
        signals <= 7'b0000100;
        aluop_reg <= 2'b01;
    end
        6'b001000: begin    //addi
        signals <= 7'b0101000;
        aluop_reg <= 2'b00;
    end
        6'b000010: begin    //j
        signals <= 7'b1000000;
        aluop_reg <= 2'b00;
    end
        default: begin
        signals <= 7'b0000000;
        aluop_reg <= 2'b00;
    end
    endcase
end

endmodule

module alu_dec(
    input wire [5:0] funct,
    input wire [1:0] op,
    output wire [2:0] alucontrol
);

reg [2:0] alucontrol_reg;
assign alucontrol = alucontrol_reg;

always @(op, funct) begin
    case(op)
        2'b00: alucontrol_reg <= 3'b000;    //Add
        2'b01: alucontrol_reg <= 3'b001;    //Sub
        2'b10: begin
            case(funct)
                6'b100000: alucontrol_reg <= 3'b000;    //Add
                6'b100010: alucontrol_reg <= 3'b001;    //Sub
                6'b100100: alucontrol_reg <= 3'b010;    //And 
                6'b100101: alucontrol_reg <= 3'b011;    //Or
                6'b101010: alucontrol_reg <= 3'b101;    //Slt
                default: alucontrol_reg <= 3'b111;
            endcase
        end
        default: alucontrol_reg <= 3'b111;
    endcase
end

endmodule

module controller(
    input wire [5:0] Op, Funct,
    output wire Jump, RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg,
    output wire [2:0] ALUContr 
);

wire [1:0] aluop;

main_dec main_dec(
    .op(Op),
    .jump(Jump),
    .regwrite(RegWrite),
    .regdst(RegDst),
    .alusrc(ALUSrc),
    .branch(Branch),
    .memwrite(MemWrite),
    .memtoreg(MemtoReg),
    .aluop(aluop)
);

alu_dec alu_dec(
    .funct(Funct),
    .op(aluop),
    .alucontrol(ALUContr)
);

endmodule
