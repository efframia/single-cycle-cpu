`timescale 1ns / 1ps

module iMem(//指令存储器
    input [31:0] _addr,
    output [31:0] idata
    );
    
    reg [7:0] imem[255:0];
    
    initial begin
    $readmemb("E:/vivado_project/code.txt",imem);//结合mars生成指令机器码
    end
    
    wire [7:0] addr = _addr[7:0];
    //wire [31:0] addr = _addr[31:0];
    assign idata = {imem[addr+3],imem[addr+2],imem[addr+1],imem[addr]};
    
    
endmodule
