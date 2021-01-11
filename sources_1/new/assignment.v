`timescale 1ns / 1ps

module assignment(
    input [31:0] idata,
    
    output [15:0] imm,
    output [4:0] rd_addr,
    output [4:0] rt_addr,
    output [4:0] rs_addr,
    output [5:0] opcode,
    output [5:0] func,
    output [25:0] instr_index
    );
    
    assign imm = idata[15:0];
    assign rd_addr = idata[15:11];
    assign rt_addr = idata[20:16];
    assign rs_addr = idata[25:21];
    assign opcode = idata[31:26];
    assign func = idata[5:0];
    assign instr_index = idata [25:0];
    
endmodule
