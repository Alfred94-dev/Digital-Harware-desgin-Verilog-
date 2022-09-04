`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 05:22:41 PM
// Design Name: 
// Module Name: func_mux
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

//design multiblexer module that takes n bit 8 inputs and generate one n bit output 
//depend on selesctor value 
module func_mux #(parameter WIDTH=4)(
    input [WIDTH-1:0] x0,x1,x2,x3,x4,x5,x6,x7, //8 inputs of n bit 
    input [2:0] sel,// to select between 8 values you need 3 bit selector 
    output reg [WIDTH-1:0] y //nbit output of mux 
    );
    always@(y,sel,x0,x1,x2,x3,x4,x5,x6,x7)
      begin 
        // using rom design for mux 
        case(sel)
             3'b000: y=x0;//selector=0 out= first input 
             3'b001: y=x1;//selector=1 out= second input 
             3'b010: y=x2;//selector=2 out= third input 
             3'b011: y=x3;//selector=3 out= fourth input 
             3'b100: y=x4;//selector=4 out= fifth input 
             3'b101: y=x5;//selector=5 out= sixth input 
             3'b110: y=x6;//selector=6 out= seventh input 
             3'b111: y=x7;//selector=7 out= eightth input 
        endcase
      end 

endmodule
