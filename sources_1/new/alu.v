`timescale 1ns / 1ps

module alu(//运算器
    input clk,//建议对照示例再好好改一下
    input rst,
    input [4:0] ctrl,//0-ADDI 1-ADDIU 2-ADD 3-SUB 4-AND 5-OR 6-SLT 7-SRL 8-SLL 9-LUI 10-SW 11-LW 12-BEQ 13-J
    
    input [31:0] alu_num1,
    input [31:0] alu_num2,
    
    output [31:0] ans,
    output error,
    output [1:0] error_message_,//0-正确，1-整型溢出，2-lw/sw地址出错，3-没有该指令
    output done_
    );
    reg [1:0] error_message;
    reg done;
    
    reg [31:0] s = 32'b0;
    
    wire [32:0] e_alu_num1 = {alu_num1[31],alu_num1};
    wire [32:0] e_alu_num2 = {alu_num2[31],alu_num2};
    
    wire [32:0] e_add_ans = e_alu_num1 + e_alu_num2;//
    wire [32:0] e_sub_ans = e_alu_num1 - e_alu_num2;//
    
    wire [31:0] and_ans = alu_num1 & alu_num2;
    wire [31:0] or_ans = alu_num1 | alu_num2;
    
    wire [31:0] slt_ans = alu_num1 < alu_num2 ? 32'b1:32'b0;
    
    wire [63:0] srl_64 = {s, alu_num2[31:0]} >> alu_num1[4:0];
    wire [31:0] srl_ans = srl_64[31:0];
    
    wire [31:0] sll_ans = alu_num2 << alu_num1[4:0];
    //wire [31:0] srl_ans = {s'b0,alu_num2[31:s]};
    //wire [31:0] srl_ans = {_s[s-1:0],alu_num2[31:s]};
    
    wire [31:0] lui_ans = {alu_num2[15:0],16'b0};
    
    wire [31:0] sw_lw_addr = e_add_ans[31:0];
    always @(posedge clk or negedge rst) begin
    if(!rst) begin
        done <= 1'b0;
        error_message <= 2'b0;
    end
    else if((ctrl == 0 || ctrl == 2 || ctrl == 3 )&&(e_add_ans[32] != e_add_ans[31])) error_message <= 2'b01;
    else if((ctrl == 10 || ctrl == 11) && ((sw_lw_addr[0] != 0) || (sw_lw_addr[1] != 0))) error_message <= 2'b10;
    else if(ctrl == 14) error_message <= 2'b11;
    else if(ctrl == 5'b11111) done <= 1'b1;
    end
    
    assign error = (error_message == 0) ? 0:1;
    assign done_ = done;
    assign error_message_ = error_message;
    
    assign ans = (ctrl == 0 || ctrl == 2) ? e_add_ans[31:0]:
                 (ctrl == 1) ? e_add_ans[32:0]:
                 (ctrl == 3) ? e_sub_ans[31:0]:
                 (ctrl == 4) ? and_ans:
                 (ctrl == 5) ? or_ans:
                 (ctrl == 6) ? slt_ans:
                 (ctrl == 7) ? srl_ans:
                 (ctrl == 8) ? sll_ans:
                 (ctrl == 9) ? lui_ans:
                 (ctrl == 10 || ctrl == 11) ? sw_lw_addr:32'b0;
endmodule
