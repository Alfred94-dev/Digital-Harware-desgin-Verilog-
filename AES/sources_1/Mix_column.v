`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 04:15:50 PM
// Design Name: 
// Module Name: Mix_column
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


module Mix_column(
    input clk, nrst, 
    input [3:0] c0,c1,c2,c3,
    input load,
    output reg [3:0] d0,d1,d2,d3,
    output  done 
    );
    wire [3:0] k0,k1,k2,k3,k4,k5,k6,k7;
    wire n0,n1,n2,n3,n4,n5,n6,n7,done_input;
    reg f0,f1,f2,f3;
    
    poly_multiplier pm0(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0011),.multiplicand(c0),.done(n0),.result(k0));
    poly_multiplier pm1(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0010),.multiplicand(c1),.done(n1),.result(k1));
    always@(n0,n1)
        begin
            if(n0 & n1) begin d0 = k0 ^ k1; f0=1'b1; end 
            else begin d0 = 4'b0000; f0=1'b0; end
        end
    poly_multiplier pm2(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0010),.multiplicand(c0),.done(n2),.result(k2));
    
    poly_multiplier pm3(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0011),.multiplicand(c1),.done(n3),.result(k3));
    
    always@(n2,n3)
        begin
            if(n2 & n3) begin d1 = k2 ^ k3; f1=1'b1; end 
            else begin d1 = 4'b0000; f1=1'b0; end
        end
    
    poly_multiplier pm4(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0011),.multiplicand(c2),.done(n4),.result(k4));
    
    poly_multiplier pm5(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0010),.multiplicand(c3),.done(n5),.result(k5));
    
    always@(n4,n5)
        begin
            if(n4 & n5) begin d2 = k4 ^ k5; f2=1'b1; end 
            else begin d2 = 4'b0000; f2=1'b0; end
        end
    
    poly_multiplier pm6(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0010),.multiplicand(c2),.done(n6),.result(k6));
    
    poly_multiplier pm7(
    .clk(clk),.n_reset(nrst),.load(load),.multiplier(4'b0011),.multiplicand(c3),.done(n7),.result(k7));
    
    always@(n6,n7)
        begin
            if(n6 & n7) begin d3 = k6 ^ k7; f3=1'b1; end 
            else begin d3 = 4'b0000; f3=1'b0; end
        end
    assign done_input = f0 & f1 & f2 & f3;
    n_bit_reg_pos #(1)save3(.D(done_input),.clk(clk),.en(1'b1),.nrst(nrst),.Q(done));

endmodule
