`timescale 1ns / 1ps

module dMem(
    input clk,
    input we,
    
    input [31:0] _addr,
    input [31:0] wdata,
    
    output [31:0] rdata
    );
    
    reg[7:0] dmem[255:0];
    initial begin
    $readmemb("E:/vivado_project/code.txt",dmem);
    end
    
    wire [7:0] addr = _addr[7:0];
    //wire [31:0] addr = _addr[31:0];
    assign rdata = {dmem[addr+3],dmem[addr+2],dmem[addr+1],dmem[addr]};
    
    always @(posedge clk) begin
        if(we)begin
            dmem[addr]<=wdata[7:0];
            dmem[addr+1]<=wdata[15:8];
            dmem[addr+2]<=wdata[23:16];
            dmem[addr+3]<=wdata[31:24];
        end
    end
    
endmodule
