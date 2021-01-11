`timescale 1ns / 1ps

module cpu_top(
    input clk,
    input rst,
    output [31:0] ans,
    output [31:0] rs_data,
    output [31:0] rt_data,
    output [31:0] mem_data,
    output [15:0] imm,
    output [31:0] pc_value
    );
    wire jmp;               //pc
    wire branch;
    wire [31:0] offset;
    wire [31:0] target;
    wire [31:0] pc_value;
    
    wire [31:0] idata;      //iMem
    
    wire [15:0] imm;        //assignment
    wire [4:0] rd_addr;
    wire [4:0] rt_addr;
    wire [4:0] rs_addr;
    wire [5:0] opcode;
    wire [5:0] func; 
    wire [25:0] instr_index;
    
    wire [31:0] ext_imm;    //sign_ext
    
    //wire [5:0] opcode;      //control_unit
    //wire [5:0] func;
    wire c1;
    wire c2;
    wire c3;
    wire c4;
    wire [4:0] cA;
    wire [1:0] cB;
    wire dmem_we;
    wire reg_we;
    
    wire [4:0] wb_addr;
    
    wire [31:0] wb_data;    //regfile
    wire [31:0] rs_data;
    wire [31:0] rt_data;
    
    wire [31:0] alu_num1;   //mux3
    
    wire [31:0] alu_num2;   //mux1
    
    wire [31:0] ans;        //alu
    wire error;
    wire [1:0] error_message_;
    wire done_;
    
    wire [31:0] mem_data;   //dMem
    
    pc pc(
        .clk(clk),
        .rst(rst),
    
        .jmp(jmp),
        .branch(branch),
        .offset(offset),
        .target(target),
    
        .pc_value(pc_value)
    );
    
    iMem iMem(
        ._addr(pc_value),
        .idata(idata)
    );
    
    assignment assignment(
        .idata(idata),
    
        .imm(imm),
        .rd_addr(rd_addr),
        .rt_addr(rt_addr),
        .rs_addr(rs_addr),
        .opcode(opcode),
        .func(func),
        .instr_index(instr_index)
    );
    
    sign_ext sign_ext(
        .imm(imm),
        .ext_imm(ext_imm)
    );
    
    control_unit control_unit(
        .opcode(opcode),
        .func(func),
    
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .c4(c4),
        .cA(cA),
        .cB(cB),
        .dmem_we(dmem_we),
        .reg_we(reg_we)
    );
    
    mux2 mux2(
        .ctrl(c2),
    
        .rt_addr(rt_addr),
        .rd_addr(rd_addr), 
        .wb_addr (wb_addr)
    );
    
    regfile regfile(
        .clk(clk),
        .rst(rst),
    
        .reg_we(reg_we),
        .rs_addr(rs_addr),
        .rt_addr(rt_addr),
        .wb_addr(wb_addr),
        .wb_data(wb_data),//这个来自mux4
    
        .rs_data(rs_data),
        .rt_data(rt_data)
    );
    
    mux3 mux3(
        .ctrl(c3),
    
        .ext_data(ext_imm),
        .rdata(rs_data), 
        .alu_num1 (alu_num1)
    );
    
    mux1 mux1(
        .ctrl(c1),
    
        .ext_data(ext_imm),
        .rdata(rt_data), 
        .alu_num2 (alu_num2)
    );
    
    alu alu(
        .clk(clk),
        .rst(rst),
        .ctrl(cA),
    
        .alu_num1(alu_num1),
        .alu_num2(alu_num2),
    
        .ans(ans),
        .error(error),
        .error_message_(error_message_),
        .done_(done_)
    );
    
    dMem dMem(
        .clk(clk),
        .we(dmem_we),
    
        ._addr(ans),
        .wdata(rt_data),
    
        .rdata(mem_data)
    );
    
    mux4 mux4(
        .ctrl(c4),
    
        .rdata(mem_data),
        .alu_result(ans), 
        .wdata (wb_data)
    );
    
    br_unit br_unit(
        .ctrl(cB),
    
        .instr_index(instr_index),
    
        .beq_num1(rs_data),
        .beq_num2(rt_data),
        .beq_offset(imm),
        .jmp_pc(pc_value),
    
        .jmp(jmp),
        .branch(branch),
        .offset(offset),
        .target(target)
    );
endmodule
