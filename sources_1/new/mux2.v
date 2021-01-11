`timescale 1ns / 1ps

module mux2(
    input ctrl,
    
    input [4:0] rt_addr,
    input [4:0] rd_addr, 
    output [4:0] wb_addr 
    );
    
    assign wb_addr  = (ctrl) ? rd_addr : rt_addr;
    
endmodule
