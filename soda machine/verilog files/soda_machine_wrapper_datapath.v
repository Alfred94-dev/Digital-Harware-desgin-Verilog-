`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 09:17:09 PM
// Design Name: 
// Module Name: soda_machine_wrapper_datapath
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


module soda_machine_wrapper_datapath(
    input clk,
    input clk_2hz,
    input start_disp,
    input rst,
    input nrst,
    input[2:0] disp_data,
    input cost,
    input cost_add,
    input coins,
    input coins_add,
    input c_wrap,
    input sw0,
    input sw1,
    input sw2,  
    input dispenced,
    output [7:0] final_cost,detected_coins,
    output CS, DC, RES, SCLK, SDO, VBAT, VDD,
    output c_final
      );
          wire [7:0] Mux_ouutput,s_sum,s_reg_adder,total_coins,a_sum;
          wire disp_done,init_done,disp_done_pulse,init_done_pulse,oled_start;
          wire [7:0] cost_dol,tot_dol,coins_hund,cost_hund,tot_hund,coins_units,cost_units,tot_units;
          reg [87:0] data;

          func_mux #(8)f1(.x0(8'b00000000),.x1(8'b00000101),.x2(8'b00001010),.x3(8'b00001111),.x4(8'b00011001),.x5(8'b00011110),.x6(8'b00100011),.x7(8'b00101000),.sel({sw2,sw1,sw0}),.y(Mux_ouutput));
           //calculate s
           n_bit_adder #(8) add1(.A(Mux_ouutput), .B(s_reg_adder), .Cin(1'b0), .Sum(s_sum), .Oflo());
           n_bit_reg #(8) s_reg_1(.D(s_sum),.clk(clk_2hz),.en(cost_add),.nrst(nrst),.Q(s_reg_adder));
           n_bit_reg #(8) s_reg_2(.D(s_reg_adder),.clk(clk_2hz),.en(cost),.nrst(nrst),.Q(final_cost));
           
           //calculate a
           n_bit_reg #(8) a_reg_1(.D(Mux_ouutput),.clk(clk_2hz),.en(coins),.nrst(nrst),.Q(detected_coins));
           n_bit_adder #(8) add2(.A(total_coins), .B(detected_coins), .Cin(1'b0), .Sum(a_sum), .Oflo());
           n_bit_reg #(8) a_reg_tot(.D(a_sum),.clk(clk_2hz),.en(coins_add),.nrst(nrst),.Q(total_coins));
           
           
               //calcute C 
          //assign c_reg_reset=c_wrap & nrst;
          n_bit_reg #(1) c_reg(.D(c_wrap),.clk(clk_2hz),.en(1'b1),.nrst(nrst),.Q(c_final));
          
          //  use oled display done and init done
          edge_to_pulse o0(.Input(disp_done),.sysclk(clk_2hz),.Reset(1'b1),.Rise(disp_done_pulse));
          edge_to_pulse o1(.Input(init_done),.sysclk(clk_2hz),.Reset(1'b1),.Rise(init_done_pulse));
          edge_to_pulse d0(.Input(dispenced),.sysclk(clk),.Reset(1'b1),.Rise(dispence_pulse));

          //edge_to_pulse o2(.Input(start_disp),.sysclk(clk_2hz),.Reset(1'b1),.Rise(oled_start));
          assign oled_start = start_disp | init_done_pulse | dispence_pulse;

    always@(init_done or disp_data or dispenced)
    begin
        if      (disp_data==3'b010) begin data = {8'h20,"cost", cost_dol ,".",cost_hund,cost_units,8'h20,8'h20}; end
        else if (disp_data==3'b011) begin data = {8'h20,8'h20,8'h20,8'h20,coins_hund,coins_units,"C",8'h20,8'h20,8'h20,8'h20}; end
        else if (disp_data==3'b100) begin data = {8'h20,8'h20,"tot", tot_dol ,".",tot_hund,tot_units,8'h20,8'h20}; end
        else if (disp_data==3'b110) begin data = {8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20}; end
        else if (dispenced | (disp_data==3'b101)) begin data = {8'h20,"DISPENCED",8'h20}; end
        else if(init_done) begin data = {8'h20,8'h20,8'h20,"Ready",8'h20,8'h20,8'h20}; end
        else begin  data = {8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20}; end    
    end

     OLED oled_inst(
    .Clock        (clk),
    .reset        (rst),
    .start_disp   (oled_start),
    .display_data (data),
    .CS           (CS),
    .DC           (DC),
    .RES          (RES),
    .SCLK         (SCLK),
    .SDO          (SDO),
    .VBAT         (VBAT),
    .VDD          (VDD),
    .DISP_DONE    (disp_done),
    .INIT_DONE    (init_done)
  );  
  oled_data x1(.coins(detected_coins),.cost(final_cost),.tot(total_coins),.cost_dol(cost_dol),.tot_dol(tot_dol),.coins_hund(coins_hund),.cost_hund(cost_hund),.tot_hund(tot_hund),.coins_units(coins_units),.cost_units(cost_units),.tot_units(tot_units));
          
          
endmodule
