`timescale 1ns / 1ps

module mux3(
    input ctrl,
    
    input [31:0] ext_data,
    input [31:0] rdata,
    output [31:0] alu_num1
    );
    
    assign alu_num1 = (ctrl) ? ext_data : rdata;
    
endmodule
