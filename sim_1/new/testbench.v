`timescale 1ns / 1ps

module testbench(
    );
    
    reg clk;
    reg rst;
    wire [31:0]ans;
    wire [31:0]rs_data;
    wire [31:0]rt_data;
    wire [31:0]mem_data;
    wire [15:0]imm;
    wire [31:0]pc_value;
    initial begin
        clk=0;
        rst=0;
        #10
        rst=1;
    $display("running...");
    end
    always #10 clk=~clk;
    
    cpu_top cpu_top(
    .clk(clk),
    .rst(rst),
    .ans(ans),
    .rs_data(rs_data),
    .rt_data(rt_data),
    .mem_data(mem_data),
    .imm(imm),
    .pc_value(pc_value)
    );
endmodule
