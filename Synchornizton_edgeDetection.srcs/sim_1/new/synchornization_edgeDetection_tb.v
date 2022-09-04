`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 09:26:41 PM
// Design Name: 
// Module Name: synchornization_edgeDetection_tb
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

//testbench for synchornization and detection system 
module synchornization_edgeDetection_tb(   );

parameter period=10; // declare a constant value of 10ns
integer i; 
// define stimulus input and output 
    reg Input_tb,sysclk_tb,Reset_tb;
    wire Rise_tb,Fall_tb;
    // instantiate the module under test 
synchornization_edgeDetection dut(.Input(Input_tb),.sysclk(sysclk_tb),.Reset(Reset_tb),.Rise(Rise_tb),.Fall(Fall_tb));
initial
begin
//test the reset system 
sysclk_tb = 1'b0; // Clock is low
Reset_tb=1'b1;// reset is not active 
#(period/4);// wait quarter period 
Reset_tb=1'b0;// activate the clock 
#period;// wait one period 
Reset_tb=1'b1;// deactivate the clk 
end

always 
//generate clock 
begin
sysclk_tb = 1'b0; // Clock is low
#(period/2); // wait for half a period
sysclk_tb = 1'b1; // set clock to high
#(period/2); // wait for half a perios
end
always 
begin
//generate different size inputs 
for(i=0;i<10;i=i+1)
begin
    Input_tb=0;// input =1
    #(period+i);// use variable delay to change width of input signal 
    Input_tb=1;// input =0 
    #(period+i+i);
end 
end



endmodule
