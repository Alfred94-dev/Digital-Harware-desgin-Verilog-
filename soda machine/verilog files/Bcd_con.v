`timescale 1ns / 1ps
module Bcd_con (output reg [3:0] S, input [3:0] A );
always@(A,S)
begin 
case(A)
4'b0000: S=4'b0000;
4'b0001: S=4'b0001;
4'b0010: S=4'b0010;
4'b0011: S=4'b0011;
4'b0100: S=4'b0100;
4'b0101: S=4'b1000;
4'b0110: S=4'b1001;
4'b0111: S=4'b1010;
4'b1000: S=4'b1011;
4'b1001: S=4'b1100;
4'b1010: S=4'b1111;
4'b1011: S=4'b1111;
4'b1100: S=4'b1111;
4'b1101: S=4'b1111;
4'b1110: S=4'b1111;
4'b1111: S=4'b1111;
endcase
end
endmodule