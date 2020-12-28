`timescale 1ns / 1ps
module alu(
    input wire [2:0] f,
    input wire [31:0] x,
    input wire [31:0] y,
    output reg [31:0] result,
    output wire zero
    );
    always @(*)
    begin
        case(f)
            3'b000: begin
                result <= x + y;
            end
            3'b001: begin
                result <= x - y;
            end
            3'b010: begin
                result <= x & y;
            end
            3'b011: begin
                result <= x | y;
            end
            3'b100: begin
                result <= ~x;
            end
            3'b101: begin
                result <= (x < y);
            end
            default: begin
                result <= 32'b0;
            end
        endcase
    end
    //assign result = reg_s;
    assign zero = (result == 32'b0) ? 1 : 0; 
endmodule
