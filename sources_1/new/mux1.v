`timescale 1ns / 1ps

module mux1(
    input ctrl,
    
    input [31:0] ext_data,
    input [31:0] rdata,
    output [31:0] alu_num2
    );
    
    assign alu_num2 = (ctrl) ? ext_data : rdata;
    
endmodule
