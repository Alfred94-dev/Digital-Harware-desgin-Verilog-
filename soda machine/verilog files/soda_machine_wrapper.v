`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 10:45:51 PM
// Design Name: 
// Module Name: soda_machine_wrapper
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

//top wrapper module 
module soda_machine_wrapper(
    input clk,
    input [3:0] sw,
    input [3:0] pb,
    output  [3:0] led,
    output CS, DC, RES, SCLK, SDO, VBAT, VDD
    );
    wire pb0_pulse_neg,a_reg_en_delay,clk_2hz;
    wire pb0_pulse, pb1_pulse,pb2_pulse,pb3_pulse;
    wire dispence,start_disp,cost,cost_add,coins,coins_add,c_wrap,c_final,dispence_pulse;
    wire [2:0] disp_data;
    wire [1:0] finish;
    wire [7:0] final_cost,detected_coin;


    //convert pushbuutons to pulses
    edge_to_pulse e0(.Input(pb[0]),.sysclk(clk),.Reset(1'b1),.Rise(pb0_pulse));
    edge_to_pulse e1(.Input(pb[1]),.sysclk(clk),.Reset(1'b1),.Rise(pb1_pulse));
    edge_to_pulse e2(.Input(pb[2]),.sysclk(clk),.Reset(1'b1),.Rise(pb2_pulse));
    edge_to_pulse e3(.Input(pb[3]),.sysclk(clk),.Reset(1'b1),.Rise(pb3_pulse));
    assign pb0_pulse_neg = ~ pb0_pulse;
    
    soda_machine_wrapper_datapath d1(
    .clk(clk),
    .clk_2hz(clk),
    .start_disp(start_disp),
    .rst(pb0_pulse),
    .nrst(pb0_pulse_neg),
    .disp_data(disp_data),
    .cost(cost),
    .cost_add(cost_add),
    .coins(coins),
    .coins_add(coins_add),
    .c_wrap(c_wrap),
    .sw0(sw[0]),
    .sw1(sw[1]),
    .sw2(sw[2]), 
    .dispenced(dispence), 
    .final_cost(final_cost),
    .detected_coins(detected_coin),
    .CS(CS), .DC(DC), .RES(RES), .SCLK(SCLK), .SDO(SDO), .VBAT(VBAT), .VDD(VDD),
    .c_final(c_final)
      );

   soda_machine_wrapper_fsm w1(
    .clk(clk),
    .nrst(pb0_pulse_neg),
    .pb0(pb0_pulse),
    .sw3(sw[3]),
    .pb1(pb1_pulse),
    .pb2(pb2_pulse),
    .pb3(pb3_pulse),
    .disp(dispence),
    .start_disp(start_disp),
    .disp_data(disp_data),
    .cost(cost),
    .cost_add(cost_add),
    .coins(coins),
    .coins_add(coins_add),
    .c_wrap(c_wrap)
    );
    n_bit_reg #(1) dis(.D(1'b1),.clk(clk),.en(dispence),.nrst(nrst),.Q(led[0]));

    soda_machine_top t1(.clk(clk),.rst(pb0_pulse),.c(c_final),.s(final_cost),.a(detected_coin),.d(dispence));

endmodule