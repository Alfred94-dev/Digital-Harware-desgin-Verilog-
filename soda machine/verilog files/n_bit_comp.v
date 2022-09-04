`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2019 07:47:10 PM
// Design Name: 
// Module Name: n_bit_comp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// n bit comparator module to comparing two nbit values if the first is less than the second it gives one else give zero 
module n_bit_comp#(parameter WIDTH = 8)( // define a default width
 input [WIDTH-1:0] A,B,
 output reg comp_res
 );
 always@(A,B)
 begin
 if(A<B)
 comp_res=1'b1; //output equal one as A less than B
 else
  comp_res=1'b0; // output = zero as B equal or larger than A
end
 
 
endmodule
