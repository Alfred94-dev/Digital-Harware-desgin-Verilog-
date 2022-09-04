`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 08:35:01 AM
// Design Name: 
// Module Name: frequency_divider_tb
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


module frequency_divider_tb( );

parameter delay=8; // declare a constant value of 8ns which equal to 1/125*10^6
//defining input and output stimulus 
    reg Clock_in_tb, Reset_tb;
    wire Clock_2Hz_tb,Clock_5Hz_tb;
    //instantiate the testing block 
frequency_divider dut(.Clock_in(Clock_in_tb),.Reset(Reset_tb),.Clock_2Hz(Clock_2Hz_tb),.Clock_5Hz(Clock_5Hz_tb));
// in the initial block we test the reset system 
initial
begin
Clock_in_tb = 1'b0; // Clock is low
Reset_tb=1'b0; // rinput reset is low so it reversed insid the block to high 
#(delay/4); // wait quarter cycle 
Reset_tb=1'b1;// activate delay
#delay;// wait one cycle 
Reset_tb=1'b0;//deactivate the reset
end
always 
begin
forever#(delay/2)Clock_in_tb=~Clock_in_tb;//forever loop change clock state every half period 

end

endmodule
