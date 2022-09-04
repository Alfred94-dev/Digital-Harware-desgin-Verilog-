`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2019 03:38:51 PM
// Design Name: 
// Module Name: poly_multiplier_datapath
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


module poly_multiplier_datapath(
    input clk,nrst,en_MPR,en_MCD,en_Rslt,MCD_check, MCD_LSB_check,calc_res,MPR_shift,MPR_check,calc_MPR,MCD_shift,final_result,
    input [3:0] multiplier, multiplicand,
    output reg done,
    output reg [3:0] result,
    output reg MCD_eq_zero,MCD_LSB,MPR_fifth
    );
    wire [7:0] multiplier_val,Rslt_val;
    wire [3:0] multiplicand_val;
    reg [7:0] multiplier_inp,Rslt_inp;
    reg [3:0] multiplicand_inp;
    reg MPR_enable,MCD_enable,RSLT_enable;
    n_bit_reg #(8)MPR(.D(multiplier_inp),.clk(clk),.en(MPR_enable),.nrst(nrst),.Q(multiplier_val));
    n_bit_reg #(4)MCD(.D(multiplicand_inp),.clk(clk),.en(MCD_enable),.nrst(nrst),.Q(multiplicand_val));
    n_bit_reg #(8)Rslt(.D(Rslt_inp),.clk(clk),.en(RSLT_enable),.nrst(nrst),.Q(Rslt_val));
    always@(en_MPR,en_MCD,en_Rslt,MCD_check, MCD_LSB_check,calc_res,MPR_shift,MPR_check,calc_MPR,MCD_shift,final_result)
        begin
            if(en_MPR & en_MCD & en_Rslt) begin
                multiplier_inp={4'b0000,multiplier};
                multiplicand_inp = multiplicand;
                Rslt_inp=8'b00000000;
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b1;
                MCD_enable=1'b1;
                RSLT_enable=1'b1;
            end
            else if (MCD_check) begin
                if (multiplicand_val ==4'b0000) begin MCD_eq_zero=1'b1; end 
                else begin MCD_eq_zero=1'b0; end
                result=4'b0000;
                done=1'b0;
                multiplier_inp=multiplier_val;
                multiplicand_inp = multiplicand_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b0;
                MCD_enable=1'b0;
                RSLT_enable=1'b0;
            end
            else if (MCD_LSB_check) begin
                  if ((multiplicand_val & 4'b0001) ==4'b0001) begin MCD_LSB=1'b1; end 
                  else begin MCD_LSB=1'b0; end
                  result=4'b0000;
                  done=1'b0;
                  MCD_eq_zero=1'b0;
                  multiplier_inp=multiplier_val;
                  multiplicand_inp = multiplicand_val;
                  Rslt_inp=Rslt_val;
                  MPR_fifth<=1'b0;
                  MPR_enable=1'b0;
                  MCD_enable=1'b0;
                  RSLT_enable=1'b0;
            end
            else if (calc_res & en_Rslt)begin
                Rslt_inp=Rslt_val^multiplier_val;
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                multiplier_inp=multiplier_val;
                multiplicand_inp = multiplicand_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b0;
                MCD_enable=1'b0;
                RSLT_enable=1'b1;
                
            end
            
            else if (MPR_shift & en_MPR)begin
                multiplier_inp={multiplier_val[6:0],1'b0};
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                multiplicand_inp = multiplicand_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b1;
                MCD_enable=1'b0;
                RSLT_enable=1'b0;
            end
            
            else if (MPR_check)begin
                if ((multiplier_val & 8'b00010000) ==8'b00010000) begin MPR_fifth=1'b1; end 
                  else begin MPR_fifth=1'b0; end
                  result=4'b0000;
                  done=1'b0;
                  MCD_eq_zero=1'b0;
                  multiplier_inp=multiplier_val;
                  multiplicand_inp = multiplicand_val;
                  Rslt_inp=Rslt_val;
                  MCD_LSB=1'b0;
                  MPR_enable=1'b0;
                  MCD_enable=1'b0;
                  RSLT_enable=1'b0;
            end
            
            else if (calc_MPR & en_MPR)begin
                multiplier_inp= multiplier_val ^ 8'b00000011;
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                multiplicand_inp = multiplicand_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b1;
                MCD_enable=1'b0;
                RSLT_enable=1'b0;
            end
            else if (MCD_shift & en_MCD)begin
                multiplicand_inp={1'b0,multiplicand_val[3:1]};
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                multiplier_inp=multiplier_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b0;
                MCD_enable=1'b1;
                RSLT_enable=1'b0;
            end
            else if (final_result)begin
                result=Rslt_val[3:0];
                done=1'b1;
                MCD_eq_zero=1'b0;
                multiplier_inp=multiplier_val;
                multiplicand_inp = multiplicand_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b0;
                MCD_enable=1'b0;
                RSLT_enable=1'b0;
            end
            else begin 
                result=4'b0000;
                done=1'b0;
                MCD_eq_zero=1'b0;
                multiplier_inp=multiplier_val;
                multiplicand_inp = multiplicand_val;
                Rslt_inp=Rslt_val;
                MCD_LSB=1'b0;
                MPR_fifth=1'b0;
                MPR_enable=1'b0;
                MCD_enable=1'b0;
                RSLT_enable=1'b0;
            end
            
        end
endmodule
