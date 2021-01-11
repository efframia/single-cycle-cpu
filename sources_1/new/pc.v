`timescale 1ns / 1ps

module pc(
    input clk,
    input rst,
    
    input jmp,
    input branch,
    input [31:0] offset,
    input [31:0] target,
    
    output [31:0] pc_value
    );
    
    wire [31:0] _offset = (branch) ? offset : 4;        //mux5
    
    reg [31:0] pc;
    
    initial begin
        pc  <= 32'h0000_3000;
    end
    
    always @ (posedge clk) begin
        if(!rst)    
            pc <= 32'h0000_3000;
        else
            case(jmp)                                   //mux6
                1:  begin   
                        pc<=target;
                    end
                0:      pc<=pc+_offset;
            endcase
    end
    
    assign pc_value = pc;
    
endmodule
