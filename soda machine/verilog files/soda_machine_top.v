`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2019 06:02:11 PM
// Design Name: 
// Module Name: soda_machine_top
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

//top module to connect FSM with datapath
module soda_machine_top(
    input clk, //input clk
    input rst, //input reset
    input c, //input coin 
    input [7:0] s, //input cost
    input [7:0] a, //input detected coin value 
    output d //dispence output 
    );
    wire nreset,tot_lt_s,tot_ld,tot_clr,s_eq_zero;
    assign nreset=~rst;//use negative reset
    //instantiate finite state machine of soda machine
    soda_machine_fsm s1(.clk_1(clk),.nrst(nreset),.c_1(c),.tot_lt_s_1(tot_lt_s),.d_1(d),.tot_ld_1(tot_ld),.tot_clr_1(tot_clr),.s_eq_zero_1(s_eq_zero));
    //instantiate datapath of soda machine
    soda_machine_datapath d1(.s_1(s),.a_1(a),.clk_2(clk),.tot_ld_2(tot_ld),.tot_clr_2(tot_clr),.tot_lt_s_2(tot_lt_s),.s_eq_zero_2(s_eq_zero));
endmodule
