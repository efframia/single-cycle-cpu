`timescale 1ns / 1ps
module control_unit(//控制模块
    input [5:0] opcode,
    input [5:0] func,
    
    output c1,
    output c2,
    output c3,
    output c4,
    output [4:0] cA,
    output [1:0] cB,
    output dmem_we,
    output reg_we
    );
    wire [4:0] inst_type;//0-ADDI 1-ADDIU 2-ADD 3-SUB 4-AND 5-OR 6-SLT 7-SRL 8-SLL 9-LUI 10-SW 11-LW 12-BEQ 13-J 14-reserved

    assign inst_type = (opcode == 6'b001000) ? 0:
                       (opcode == 6'b001001) ? 1:
                       (opcode == 6'b001111) ? 9:
                       (opcode == 6'b101011) ? 10:
                       (opcode == 6'b100011) ? 11:
                       (opcode == 6'b000100) ? 12:
                       (opcode == 6'b000010) ? 13:
                       (opcode == 6'b000000) ? (
                           (func == 6'b100000) ? 2:
                           (func == 6'b100010) ? 3:
                           (func == 6'b100100) ? 4:
                           (func == 6'b100101) ? 5:
                           (func == 6'b101010) ? 6:
                           (func == 6'b000010) ? 7:
                           (func == 6'b000000) ? 8:14 ):14;
    
    assign c1 = (inst_type == 0 || inst_type == 1 || inst_type == 9 || inst_type == 10 || inst_type == 11) ? 1:0;
    assign c2 = (inst_type == 2 || inst_type == 3 || inst_type == 4 || inst_type == 5 || inst_type == 6 || inst_type == 7 || inst_type == 8) ? 1:0;
    assign c3 = (inst_type == 7 || inst_type == 8 || inst_type == 9) ? 1:0;
    assign c4 = (inst_type == 11) ? 1:0;
    /*assign cA = (inst_type == 0 || inst_type == 12 || inst_type == 13) ? 9'b000000001:
                (inst_type == 1) ? 9'b000000010:
                (inst_type == 2) ? 9'b000000100:
                (inst_type == 3) ? 9'b000001000:
                (inst_type == 4) ? 9'b000010000:
                (inst_type == 5) ? 9'b000100000:
                (inst_type == 6) ? 9'b001000000:
                (inst_type == 7) ? 9'b010000000:
                (inst_type == 8) ? 9'b100000000:9'b000000000;*/
    assign cA = inst_type;
    assign cB = (inst_type == 12) ? 2'b01:
                (inst_type == 13) ? 2'b10: 2'b00;
    assign dmem_we = (inst_type == 10) ? 1:0;
    assign reg_we = (inst_type == 10 || inst_type == 12 || inst_type == 13) ? 0:1;
    
endmodule
