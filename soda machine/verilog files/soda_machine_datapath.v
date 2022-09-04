`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2019 06:02:11 PM
// Design Name: 
// Module Name: soda_machine_datapath
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


module soda_machine_datapath(
    input [7:0] s_1,
    input [7:0] a_1,
    input clk_2,
    input tot_ld_2,
    input tot_clr_2,
    output tot_lt_s_2,
    output reg s_eq_zero_2
    );
    wire [7:0] reg_out, sum_out;
    wire tot_clr_2_n;
    assign tot_clr_2_n=~tot_clr_2; //use negative reset with register 
    //define 8 bit register for save the total number of coins
    n_bit_reg #(8) reg1(.D(sum_out),.clk(clk_2),.en(tot_ld_2),.nrst(tot_clr_2_n),.Q(reg_out));
    //full adder to add the added coins to the previous values of coins 
    n_bit_adder #(8) add1(.A(a_1), .B(reg_out), .Cin(1'b0), .Sum(sum_out), .Oflo());
    //comparator to compare the total coins with cost 
    n_bit_comp #(8) c1(.A(reg_out),.B(s_1),.comp_res(tot_lt_s_2));
    //always block to check the cost value if it is equal to zero or not 
    always@(s_1)
     begin
        if (s_1 == 0)
            begin
                s_eq_zero_2=1;
            end
         else
            begin
                s_eq_zero_2=0;

            end
    end         
            
        

endmodule
