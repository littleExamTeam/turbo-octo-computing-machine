`timescale 1ns / 1ps
`include "defines.vh"

module alu(
    input wire [7:0] aluControl,
    input wire [31:0] x,//SrcAE
    input wire [31:0] y,//SrcBE
    output reg [31:0] result,
    output wire zero
    );

    always @(*)
    begin
        case(aluControl)
            `EXE_ADD_OP: begin result <= x + y;end  //加法
            `EXE_ADDI_OP: begin result <= x + y;end //减法
            `EXE_ADDU_OP: begin result <= x + y;end //无符号数加法
            `EXE_ADDIU_OP: begin result <= x + y;end //无符号立即数加法
            `EXE_SUB_OP: begin result <= x - y;end  //减法
            `EXE_SUBU_OP: begin result <= x - y;end //无符号数减法
            `EXE_SLT_OP: begin 
                if (x < y)begin 
                    result <= 32'b1;
                end else begin
                    result <= 32'b0;
                end
            end //将寄存器 rs 的值与寄存器 rt 中的值进行有符号数比较，如果寄存器 rs 中的值小，则寄存器 rd 置 1；
                //否则寄存器 rd 置 0

            `EXE_SLTI_OP: begin 
                if (x < y)begin 
                    result <= 32'b1;
                end else begin
                    result <= 32'b0;
                end
            end//将寄存器 rs 的值与有符号扩展至 32 位的立即数 imm 进行有符号数比较，如果寄存器 rs 中的值小，
                //则寄存器 rt 置 1；否则寄存器 rt 置 0。


            `EXE_SLTU_OP: begin 
                if (x < y)begin 
                    result <= 32'b1;
                end else begin
                    result <= 32'b0;
                end
            end  //将寄存器 rs 的值与寄存器 rt 中的值进行无符号数比较，如果寄存器 rs 中的值小，则寄存器 rd 置 1；
                //否则寄存器 rd 置 0

            
            `EXE_SLTIU_OP: begin
                 if (x < y)begin 
                    result <= 32'b1;
                end else begin
                    result <= 32'b0;
                end
            end //将寄存器 rs 的值与寄存器 rt 中的值进行有符号数比较，如果寄存器 rs 中的值小，则寄存器 rd 置 1；
                //否则寄存器 rd 置 0
            
            `EXE_DIV_OP: begin result <= x + y;end //TODO:这里预计的是将乘法器写在通路里，通过选择器进行选择
            `EXE_DIVU_OP: begin result <= x | y;end
            `EXE_MULT_OP: begin result <= x + y;end  
            `EXE_MULTU_OP: begin result <= x - y;end 

            //这下面是逻辑运算符
            `EXE_AND_OP: begin 
                result <= x & y;
            end //寄存器 rs 中的值与寄存器 rt 中的值按位逻辑与，结果写入寄存器 rd 中


            `EXE_ANDI_OP: begin 
                result <= x & y;
            end //寄存器 rs 中的值与 0 扩展至 32 位的立即数 imm 按位逻辑与，结果写入寄存器 rt 中


            `EXE_LUI_OP: begin 
                result <= x + y;
            end  //将 16 位立即数 imm 写入寄存器 rt 的高 16 位，寄存器 rt 的低 16 位置 0。
                //TODO:这里需要更改通路 

            `EXE_NOR_OP: begin 
                result <= !(x | y);
            end //寄存器 rs 中的值与寄存器 rt 中的值按位逻辑或非，结果写入寄存器 rd 中

            `EXE_OR_OP: begin result <= x | y;end 
            `EXE_ORI_OP: begin result <= x | y;end
            `EXE_XOR_OP: begin result <= x ^ y;end  
            `EXE_XORI_OP: begin result <= x ^ y;end 

            //这下面是移位指令
            `EXE_SLLV_OP: begin result <= y << x[4:0];end //逻辑左移0填充

            `EXE_SLL_OP: begin 
                result <= x | y;
            end //由立即数 sa 指定移位量，对寄存器 rt 的值进行逻辑左移，结果写入寄存器 rd 中。
            //TODO:这里也需要修改数据通路，用0填充

            `EXE_SRAV_OP: begin result <= y >> x[4:0];end  //逻辑右移TODO:这里需要将使用y[31]进行填充

            `EXE_SRA_OP: begin 
                result <= x - y;
            end //由立即数 sa 指定移位量，对寄存器 rt 的值进行算术右移，结果写入寄存器 rd 中
                //TODO:这里需要修改数据通路，应该是和上面的那个一样的问题，另外需要用rt[31]进行填充

            `EXE_SRLV_OP: begin result <= y >> x[4:0];end //逻辑右移0填充

            `EXE_SRL_OP: begin 
                result <= x | y;
            end//由立即数 sa 指定移位量，对寄存器 rt 的值进行逻辑右移，结果写入寄存器 rd 中。
                //TODO:需要修改数据通路实现，原因跟上面一致，用0填充

            //下面是分支跳转指令
            // `EXE_BEQ_OP: begin result <= x + y;end  //加法
            // `EXE_BNE_OP: begin result <= x - y;end //减法
            // `EXE_BGEZ_OP: begin result <= x + y;end //无符号数加法
            // `EXE_BGTZ_OP: begin result <= x | y;end
            // `EXE_BLEZ_OP: begin result <= x + y;end  //加法
            // `EXE_BLTZ_OP: begin result <= x - y;end //减法
            // `EXE_BGEZAL_OP: begin result <= x + y;end //无符号数加法
            // `EXE_BLTZAL_OP: begin result <= x | y;end
            // `EXE_J_OP: begin result <= x + y;end  //加法
            // `EXE_JAL_OP: begin result <= x - y;end //减法
            // `EXE_JR_OP: begin result <= x + y;end //无符号数加法
            // `EXE_JALR_OP: begin result <= x | y;end


            //TODO:下面是数据移动指令，需要用到HILO寄存器
            // `EXE_MFHI_OP: begin result <= x | y;end
            // `EXE_MFLO_OP: begin result <= x + y;end  //加法
            // `EXE_MTHI_OP: begin result <= x - y;end //减法
            // `EXE_MTLO_OP: begin result <= x + y;end //无符号数加法

            // //自陷指令
            // `EXE_BREAK_OP: begin result <= x | y;end
            // `EXE_SYSCALL_OP: begin result <= x + y;end  //加法

            //TODO:访存指令,这里需要大幅度修改数据通路
            `EXE_LB_OP: begin result <= x - y;end //减法
            `EXE_LBU_OP: begin result <= x + y;end //无符号数加法
            `EXE_LH_OP: begin result <= x | y;end
            `EXE_LHU_OP: begin result <= x | y;end
            `EXE_LW_OP: begin result <= x + y;end  //加法
            `EXE_SB_OP: begin result <= x - y;end //减法
            `EXE_SH_OP: begin result <= x + y;end //无符号数加法
            `EXE_SW_OP: begin result <= x | y;end

            // //特权指令
            // `EXE_ERET_OP: begin result <= x + y;end  //加法
            // `EXE_MFC0_OP: begin result <= x - y;end //减法
            // `EXE_MTC0_OP: begin result <= x + y;end //无符号数加法
            
            default: begin
                result <= 32'b0;
            end
        endcase
    end
    //assign result = reg_s;
    assign zero = (result == 32'b0) ? 1 : 0; 
endmodule
