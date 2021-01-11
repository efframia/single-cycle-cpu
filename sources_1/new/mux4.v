`timescale 1ns / 1ps

module mux4(
    input ctrl,
    
    input [31:0] rdata,
    input [31:0] alu_result,
    output [31:0] wdata
    );
    
    assign wdata = (ctrl) ? rdata : alu_result;
    
endmodule
