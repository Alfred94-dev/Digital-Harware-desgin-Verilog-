`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 10:48:54 PM
// Design Name: 
// Module Name: bin_asci
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

//take 4 bit binary and generat hexadicmal ascii code equivalent 
module bin_asci(
    input [3:0] bin,  
    output reg [7:0] hex
    );
    always@(bin)
        begin
        case(bin)
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
        4'b1010: hex=8'h61;
        4'b1011: hex=8'h62;
        4'b1100: hex=8'h63;
        4'b1101: hex=8'h64;
        4'b1110: hex=8'h65;
        4'b1111: hex=8'h66;
        default: hex=8'h20;// default is space
        endcase
      end 
endmodule    


