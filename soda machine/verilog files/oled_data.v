`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 07:36:22 PM
// Design Name: 
// Module Name: oled_data
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


module oled_data(
    input [7:0] coins, cost,tot,   
    output [7:0] cost_dol,tot_dol,coins_hund,cost_hund,tot_hund,coins_units,cost_units,tot_units
    );
    wire [9:0] coins_bcd, cost_bcd,tot_bcd;
    Binary_2_BCD n1(.bcd(coins_bcd),.bin(coins));
    Binary_2_BCD n2(.bcd(cost_bcd),.bin(cost));
    Binary_2_BCD n3(.bcd(tot_bcd),.bin(tot));
    bcd_hex b1(.bcd({00,cost_bcd[9:8]}),.hex(cost_dol));
    bcd_hex b2(.bcd({00,tot_bcd[9:8]}),.hex(tot_dol));
    bcd_hex b3(.bcd(coins_bcd[7:4]),.hex(coins_hund));
    bcd_hex b4(.bcd(cost_bcd[7:4]),.hex(cost_hund));
    bcd_hex b5(.bcd(tot_bcd[7:4]),.hex(tot_hund));
    bcd_hex b6(.bcd(coins_bcd[3:0]),.hex(coins_units));
    bcd_hex b7(.bcd(cost_bcd[3:0]),.hex(cost_units));
    bcd_hex b8(.bcd(tot_bcd[3:0]),.hex(tot_units));

endmodule
module bcd_hex(
    input [3:0] bcd,  
    output reg [7:0] hex
    );
    always@(bcd)
        begin
        case(bcd)
        4'b0000: hex=8'h30;
        4'b0001: hex=8'h31;
        4'b0010: hex=8'h32;
        4'b0011: hex=8'h33;
        4'b0100: hex=8'h34;
        4'b0101: hex=8'h35;
        4'b0110: hex=8'h36;
        4'b0111: hex=8'h37;
        4'b1000: hex=8'h38;
        4'b1001: hex=8'h39;
        default: hex=8'h20;// default is space
        endcase
      end 
endmodule    
