`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2019 05:51:15 PM
// Design Name: 
// Module Name: AES_tb
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


module AES_tb(
    );
parameter period=10; // declare a constant value of 20ns
reg clk_tb,n_reset_tb,load_tb;
reg [15:0] data_input_tb, input_vector_tb,key_tb;
reg [3:0] round_number_tb;
wire [15:0]data_output_tb;
wire finish_tb;
integer i;

AES a1(
    .clk(clk_tb),
    .nrst(n_reset_tb), 
    .data_input(data_input_tb),
    .input_vector(input_vector_tb),
    .key(key_tb),
    .round_number(round_number_tb),
    .data_output(data_output_tb),
    .finish(finish_tb)
    );
    
    
    initial
    begin
    //test the reset system 
        clk_tb = 1'b0; // Clock is low
        n_reset_tb=1'b1;// reset is not active 
        #(period);// wait quarter period 
        n_reset_tb=1'b0;// activate the clock 
        for(i=0;i<1;i=i+1)begin #period;  end 
        n_reset_tb=1'b1;// deactivate the clk
        for(i=0;i<3;i=i+1)begin #period;  end 
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
      //data_input_tb=16'b1001110001100011;
       data_input_tb=16'h1337;
       input_vector_tb=16'b0000000000000000;
       key_tb=16'h5480;
       //key_tb=16'b1100001111110000;
       round_number_tb=4'b0110;
        for(i=0;i<2500;i=i+1)begin #period;  end
        
        
        
   
        $stop;

    end
endmodule
