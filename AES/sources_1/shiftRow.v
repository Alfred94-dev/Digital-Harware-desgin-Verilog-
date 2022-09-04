`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 08:15:47 PM
// Design Name: 
// Module Name: shiftRow
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


module shiftRow(
    input [15:0] b, 
    input clk,
    input en,
    output reg valid,
    output reg [15:0] c
    );
     always@(posedge clk)
        begin
//if enable shift row using concatenation 
            if (en) begin
                c <= {b[15:12],b[3:0],b[7:4],b[11:8]};
                valid <= 1'b1;
            end
         else begin 
            c <=16'b0000000000000000;
            valid <= 1'b0;
         end
          
        end
endmodule
