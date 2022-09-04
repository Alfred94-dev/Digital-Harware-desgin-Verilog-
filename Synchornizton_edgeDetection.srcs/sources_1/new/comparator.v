`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 09:01:17 PM
// Design Name: 
// Module Name: comparator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// this module take 2 inputs which are signal value  and previous value and generate two outputs 
// rise and fall to indicate if positive edge or negative edge happened
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comparator(
    input inp1,
    input inp2,
    output out_rise,
    output out_fall
    );
    // if signal value now is equal to one and its previous value was zero its rising
    assign out_rise = inp1 & (!inp2);
     // if signal value now is equal to zero and its previous value was one its falling
    assign out_fall = inp2 & (!inp1);
endmodule
