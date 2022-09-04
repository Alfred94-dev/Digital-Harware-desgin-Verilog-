`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2019 12:29:40 PM
// Design Name: 
// Module Name: n_bit_reg
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

// module to design n bit register tha has negative reset and input cl and enable and input data
//the output data = nbit input at rising edge of the clock when reset=1 and en=1
module n_bit_reg #(parameter WIDTH = 32)( // define a default width
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
