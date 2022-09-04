`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:17:42 PM
// Design Name: 
// Module Name: key_generation
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


module key_generation(
    input clk,nrst,load,
    input [3:0] round_num,
    input [15:0] key,
    output [15:0] round1,
    output  done 
    );
    wire [3:0] nibres1;
    reg [3:0] w4,w5,w6,w7;
    reg load2,en1,done_en,done_inp;
    wire valid1;
    reg [15:0] inp1;
    NibbleSub ns0(
     .a(key[3:0]),
     .clk(clk),
     .en(load),
     .valid(valid1),
     .b(nibres1));
     
     n_bit_reg #(16)r1(.D(inp1),.clk(clk),.en(en1),.nrst(nrst),.Q(round1));
    n_bit_reg #(1)f(.D(done_inp),.clk(clk),.en(done_en),.nrst(nrst),.Q(done));

    always@(valid1)
        begin
            if (valid1) begin
                w4 = key[15:12] ^ nibres1 ^ round_num;
                w5 = key[11:8] ^ w4;
                w6 = key[7:4] ^ w5; 
                w7 = key[3:0] ^ w6;
                inp1={w4,w5,w6,w7};
                en1=1'b1;
                done_en=1'b1;
                done_inp=1'b1;
            end

            else begin
                load2 = 1'b0;
                inp1=16'b0000000000000000;
                en1=1'b0;
                done_en=1'b1;
                done_inp=1'b0;
                w4=4'b0000;
                w5=4'b0000;
                w6=4'b0000;
                w7=4'b0000; 
            end
            
            
           
        end
endmodule
