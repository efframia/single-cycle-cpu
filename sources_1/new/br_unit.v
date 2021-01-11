`timescale 1ns / 1ps

module br_unit(
    input [1:0] ctrl,
    
    input [25:0] instr_index,
    
    input [31:0] beq_num1,
    input [31:0] beq_num2,
    input [15:0] beq_offset,
    input [31:0] jmp_pc,
    
    output jmp,
    output branch,
    output [31:0] offset,
    output [31:0] target
    );
    
    /*reg _branch;
    reg _jmp;
    
    always @(ctrl) begin
        case(ctrl)    
            2'b01: begin
                    _branch <= (beq_num1 == beq_num2) ? 1:0;
                end
            2'b10:  _jmp <= 1;
            default:   _jmp <= 0;
        endcase
    end
    
    assign branch = _branch;
    assign jmp = _jmp;*/
    //assign branch = (beq_num1 == beq_num2) ? 1:0
   // assign jmp = 1;
   //assign branch = ( (ctrl == 2'b01) && (beq_num1 == beq_num2)) ? 1:0;
   assign branch = ( ctrl == 2'b01 ) ? 1:0;
   assign jmp = (ctrl == 2'b10) ? 1:0;
    
    wire [17:0] beq_shift = {beq_offset,2'b0};
    assign offset = {{14{beq_shift[15]}},beq_shift};
    
    assign target = {jmp_pc[31:28], instr_index, 2'b0};
    
endmodule
