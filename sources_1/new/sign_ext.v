`timescale 1ns / 1ps

module sign_ext(
    input [15:0] imm,
    output [31:0] ext_imm
    );
    assign ext_imm = {{16{imm[15]}},imm};
endmodule
