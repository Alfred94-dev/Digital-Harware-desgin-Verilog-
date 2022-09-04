`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 06:58:01 PM
// Design Name: 
// Module Name: AES_wrapper
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


module AES_wrapper(
    input clk,
    input [3:0] pb,
    input [3:0] sw,
    output  led,
    output CS, DC, RES, SCLK, SDO, VBAT, VDD
    );
    wire pb0_pulse,pb1_pulse,pb3_pulse,nrst;
    wire v0,v1,v2,v3,m0,m1,m2,m3,k0,k1,k2,k3,ron,start_enc,disp,finished,oled_enc,oled_start,disp_done,init_done;
    wire [7:0] s0,s1,s2,s3;
    reg [87:0] data;

    assign nrst = ~pb0_pulse;
    assign led =~finished;
    assign oled_start= init_done|oled_enc;

    edge_to_pulse e0(.Input(pb[0]),.sysclk(clk),.Reset(1'b1),.Rise(pb0_pulse));
    edge_to_pulse e1(.Input(pb[1]),.sysclk(clk),.Reset(1'b1),.Rise(pb1_pulse));
    edge_to_pulse e2(.Input(pb[3]),.sysclk(clk),.Reset(1'b1),.Rise(pb3_pulse));
   //debounce deb1(.pb_1(pb[1]),.clk(clk),.pb_out(pb1_pulse));
   //debounce deb3(.pb_1(pb[3]),.clk(clk),.pb_out(pb3_pulse));
   
   //instantiate oled module 
    OLED oled_inst(
    .Clock        (clk),
    .reset        (pb0_pulse),
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
  always@(init_done,oled_enc)
    begin
    if (oled_enc) begin  data = {8'h20,"ENC",8'h20,"=",s3,s2,s1,s0,8'h20}; end 
    else if (init_done) begin  data = {8'h20,8'h20,8'h20,"READY",8'h20,8'h20,8'h20}; end 
    else begin data = {8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20}; end
    end
  AES_wrapper_datapath d9(
     .clk(clk),
     .nrst(nrst),
     .v0(v0),
     .v1(v1),
     .v2(v2),
     .v3(v3),
     .m0(m0),
     .m1(m1),
     .m2(m2),
     .m3(m3),
     .k0(k0),
     .k1(k1),
     .k2(k2),
     .k3(k3),
     .ron(ron),
     .start_enc(start_enc),
     .disp(disp),
      .sw(sw),
     .finished(finished),
     .oled_enc(oled_enc),
     .s0(s0),
     .s1(s1),
     .s2(s2),
     .s3(s3)
    );
    
    AES_wrapper_FSM f9(
    .clk(clk),
    .nrst(nrst),
    .pb1_pulse(pb1_pulse),
    .pb3_pulse(pb3_pulse),
    .finished(finished),
    .v0(v0),
    .v1(v1),
    .v2(v2),
    .v3(v3),
    .m0(m0),
    .m1(m1),
    .m2(m2),
    .m3(m3),
    .k0(k0),
    .k1(k1),
    .k2(k2),
    .k3(k3),
    .ron(ron),
    .start_enc(start_enc),
    .disp(disp)
    );

endmodule
