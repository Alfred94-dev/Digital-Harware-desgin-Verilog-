`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 07:29:26 PM
// Design Name: 
// Module Name: NibbleSub
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


module NibbleSub(
    input [3:0] a,
    input clk,
    input en,
    output reg valid,
    output reg [3:0] b
    );
    always@(posedge clk)
        begin
// if enable =1 use rom design 
            if (en) begin 
                case (a)
                    4'b0000: b <= 4'b1110;
                    4'b0001: b <= 4'b0100;
                    4'b0010: b <= 4'b1101;
                    4'b0011: b <= 4'b0001;
                    4'b0100: b <= 4'b0010;
                    4'b0101: b <= 4'b1111;
                    4'b0110: b <= 4'b1011;
                    4'b0111: b <= 4'b1000; 
                    4'b1000: b <= 4'b0011;
                    4'b1001: b <= 4'b1010;
                    4'b1010: b <= 4'b0110;
                    4'b1011: b <= 4'b1100;
                    4'b1100: b <= 4'b0101;
                    4'b1101: b <= 4'b1001;
                    4'b1110: b <= 4'b0000;
                    4'b1111: b <= 4'b0111;
                    default: b <= 4'b0000; 
            endcase
            valid <= 1'b1;
         end
         else begin 
         b <= 4'b0000;
         valid <= 1'b0;
         end
          
        end
endmodule
