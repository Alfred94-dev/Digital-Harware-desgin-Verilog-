`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2019 03:38:51 PM
// Design Name: 
// Module Name: poly_multiplier
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


module poly_multiplier(
    input clk,n_reset,load,
    input [3:0] multiplier, multiplicand,//two 4 bits inputs 
    output done,//done flag
    output [3:0] result // 4bit output result 
    );
    wire MCD_eq_zero,MCD_LSB,MPR_fifth,en_MPR,en_MCD,MCD_check,MCD_LSB_check,calc_res,MPR_shift,MPR_check;
    wire calc_MPR,MCD_shift,final_result,en_Rslt;
        //instantiate FSM
    poly_multiplier_FSM f1(
    .clk(clk),
    .nrst(n_reset),
    .load(load),
    .MCD_eq_zero(MCD_eq_zero),
    .MCD_LSB(MCD_LSB),
    .MPR_fifth(MPR_fifth),
    .en_MPR(en_MPR),
    .en_MCD(en_MCD),
    .en_Rslt(en_Rslt),
    .MCD_check(MCD_check), 
    .MCD_LSB_check(MCD_LSB_check),
    .calc_res(calc_res),
    .MPR_shift(MPR_shift),
    .MPR_check(MPR_check),
    .calc_MPR(calc_MPR),
    .MCD_shift(MCD_shift),
    .final_result(final_result)
    );
    
        //instantiate datpath 
    poly_multiplier_datapath d1(
    .clk(clk),
    .nrst(n_reset),
    .en_MPR(en_MPR),
    .en_MCD(en_MCD),
    .en_Rslt(en_Rslt),
    .MCD_check(MCD_check),
    .MCD_LSB_check(MCD_LSB_check),
    .calc_res(calc_res),
    .MPR_shift(MPR_shift),
    .MPR_check(MPR_check),
    .calc_MPR(calc_MPR),
    .MCD_shift(MCD_shift),
    .final_result(final_result),
    .multiplier(multiplier), 
    .multiplicand(multiplicand),
    .done(done),
    .result(result),
    .MCD_eq_zero(MCD_eq_zero),
    .MCD_LSB(MCD_LSB),
    .MPR_fifth(MPR_fifth)
    );
endmodule
