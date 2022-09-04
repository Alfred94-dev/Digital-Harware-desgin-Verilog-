`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 09:01:17 PM
// Design Name: 
// Module Name: synchornization_edgeDetection
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// this module synchoronize signal with clock and then detect if rising or falling edge happened 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module synchornization_edgeDetection(
    input Input,// input signal to be synchoronized and detect its edges 
    input sysclk,//clk that the input will be synchoronzed with 
    input Reset,//reset system 
    output Rise,// 1 if rise edge detected in the synchornized signal
    output Fall// 1 if falling edge detected in the synchornized signal
    );
    //define wires to conect flip flops with each other 
    wire q1_d2,q2_d3_inp1,q3_inp2;
   //first two flip flops to synchoronize the signal
    d_FlipFlop f1(.Clk(sysclk),.Rst(Reset),.D(Input),.Q(q1_d2));
    d_FlipFlop f2(.Clk(sysclk),.Rst(Reset),.D(q1_d2),.Q(q2_d3_inp1));
    //get the current value of the synchoronized signal from the output of FF2
    //get the previous value of the synchoronized signal from the output of FF3
    d_FlipFlop f3(.Clk(sysclk),.Rst(Reset),.D(q2_d3_inp1),.Q(q3_inp2));
    //insert the current value and the previous value of the signal for detecting rise and fall 
    comparator c1(.inp1(q2_d3_inp1),.inp2(q3_inp2),.out_rise(Rise),.out_fall(Fall));
    
endmodule
