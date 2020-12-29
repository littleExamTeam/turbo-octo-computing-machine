`timescale 1ns / 1ps
`include "defines.vh"

module main_dec(
    input wire [5:0] op,
    output wire jump, regwrite, regdst, 
    output wire [1:0] alusrc, //这里修改成两位是为了选择操作数，0位扩展
    output wire branch, memwrite, memtoreg
);

reg [7:0] signals;

assign {jump, regwrite, regdst, alusrc[1:0], branch, memwrite, memtoreg} = signals;
// `define EXE_NOP			6'b000000
// `define EXE_AND 		6'b100100
// `define EXE_OR 			6'b100101
// `define EXE_XOR 		6'b100110
// `define EXE_NOR			6'b100111
// `define EXE_ANDI		6'b001100
// `define EXE_ORI			6'b001101
// `define EXE_XORI		6'b001110
// `define EXE_LUI			6'b001111
always @(op) begin
    case(op)
    //     `EXE_NOP: begin    //R-type
    //     signals <= 8'b011 000;
    //     aluop_reg <= 2'b10;
    // end
        `EXE_AND: begin    //lw
        signals <= 8'b01100000;
    end
        `EXE_OR: begin    //sw
        signals <= 8'b01100000;
    end
        `EXE_XOR: begin    //beq
        signals <= 8'b01100000;
    end
        `EXE_NOR: begin    //addi
        signals <= 8'b01100000;
    end
        `EXE_ANDI: begin    //j
        signals <= 8'b01110000;
    end
        `EXE_XORI: begin    //j
        signals <= 8'b01110000;
    end
        `EXE_ORI: begin    //j
        signals <= 8'b01110000;
    end
        `EXE_LUI: begin    //j
        signals <= 8'b01110000;
    end
        default: begin
        signals <= 8'b00000000;
    end
    endcase
end

endmodule



// module alu_dec(
//     input wire [5:0] funct,
//     input wire [1:0] op,
//     output wire [7:0] alucontrol
// );

// reg [7:0] alucontrol_reg;
// assign alucontrol = alucontrol_reg;

// always @(op, funct) begin
//     case(op)
//         2'b00: alucontrol_reg <= 3'b000;    //Add
//         2'b01: alucontrol_reg <= 3'b001;    //Sub
//         2'b10: begin
//             case(funct)
//                 6'b100000: alucontrol_reg <= 3'b000;    //Add
//                 6'b100010: alucontrol_reg <= 3'b001;    //Sub
//                 6'b100100: alucontrol_reg <= 3'b010;    //And 
//                 6'b100101: alucontrol_reg <= 3'b011;    //Or
//                 6'b101010: alucontrol_reg <= 3'b101;    //Slt
//                 default: alucontrol_reg <= 3'b111;
//             endcase
//         end
//         default: alucontrol_reg <= 3'b111;
//     endcase
// end

// endmodule

module controller(
    input wire [5:0] Op, Funct,
    output wire Jump, RegWrite, RegDst,
    output wire [1:0] ALUSrc, 
    output wire Branch, MemWrite, MemtoReg,
    output wire [7:0] ALUContr 
);


main_dec main_dec(
    .op(Op),
    .jump(Jump),
    .regwrite(RegWrite),
    .regdst(RegDst),
    .alusrc(ALUSrc),
    .branch(Branch),
    .memwrite(MemWrite),
    .memtoreg(MemtoReg)
);

aludec aludec(
    .Funct(Funct),
    .Op(Op),
    .ALUControl(ALUContr)
);

endmodule
