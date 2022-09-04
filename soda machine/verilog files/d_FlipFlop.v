`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 09:01:17 PM
// Design Name: 
// Module Name: d_FlipFlop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// this module is D- flipflop design which take clk and active low reset
// and input d and generate one output q 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module d_FlipFlop(
    input Clk,
    input Rst,
    input D,
    output reg Q
    );
    //flip flop is synchoronized with poitive eddge of the clock and negative edge of reset 
    always@(negedge Clk or negedge Rst)
    begin
    //if reset==0 flip flop output =0
        if (!Rst)
            Q <= 1'b0;
        else
        // if reset =1 and their is negative edge of the clock output = input
            Q <= D;
     end
endmodule
