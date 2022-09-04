`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 12:19:14 PM
// Design Name: 
// Module Name: soda_machine_top_tb
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


module soda_machine_top_tb();
parameter period=10; // declare a constant value of 10ns
parameter nickel=5; // declare a constant value of 5 represents nickels
parameter dime=10; // declare a constant value of 10 represents dimes
parameter quarter=25; // declare a constant value of 25 represents quarter
reg clk_tb,rst_tb,c_tb;
reg [7:0] s_tb,a_tb;
wire d_tb;
integer i; 
//instatiate top file
soda_machine_top s1(.clk(clk_tb),.rst(rst_tb),.c(c_tb),.s(s_tb),.a(a_tb),.d(d_tb));
initial
    begin
        //test the reset system 
        clk_tb = 1'b0; // Clock is low
        c_tb= 1'b0;
        rst_tb=1'b0;// reset is not active 
        #(period/4);// wait quarter period 
        rst_tb=1'b1;// activate the clock 
        #period;// wait one period 
        rst_tb=1'b0;// deactivate the clk 
    end
always 
    //generate clock 
    begin
        clk_tb = 1'b0; // Clock is low
        #(period/2); // wait for half a period
        clk_tb = 1'b1; // set clock to high
        #(period/2); // wait for half a perios
    end

always
    begin
        s_tb=150;
        #period;// wait one period
        #period;// wait one period
        #period;// wait one period 
        //put 4 quarters
        for(i=0;i<4;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=quarter;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end
            ////put 5 nickels
        for(i=0;i<5;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=dime;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end
            //put 3 dimes
        for(i=0;i<3;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=nickel;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end

        #period;// wait one period 
        rst_tb=1'b1;// activate the reset 
        #period;// wait one period 
        rst_tb=1'b0;// deactivate the reset
         s_tb=200;//set the cost to 2$
         #period;// wait one period 
         //put 6 quarters
        for(i=0;i<6;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=quarter;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end
            //put 4 nickels
        for(i=0;i<4;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=dime;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end
            ////put 2 dimes
        for(i=0;i<2;i=i+1)
            begin
                c_tb= 1'b1;
                a_tb=nickel;
                #period;// wait one period
                c_tb= 1'b0;
                #(period);// wait one period
            end
         #period;// wait one period
         #period;// wait one period
         $stop;// stop simulation 

    end
endmodule
