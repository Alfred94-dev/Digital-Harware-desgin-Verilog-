`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2019 07:07:10 PM
// Design Name: 
// Module Name: n_bit_reg_pos
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


module n_bit_reg_pos
    #(parameter WIDTH = 32)( // define a default width
 input [WIDTH-1:0] D,
 input clk, en, nrst,
 output reg [WIDTH-1:0] Q
 );
//system trigered at positive edge of the clock or negative edge of reset
 always @(posedge clk or negedge nrst)
    begin
        if (!nrst) begin // Low-active reset signal
            Q <= 0;//output =zero
        end
        else if (en) begin // high-active enable signal
            Q <= D; //output = input
        end
    end
endmodule
