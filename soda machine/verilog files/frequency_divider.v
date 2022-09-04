`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2019 10:32:03 PM
// Design Name: 
// Module Name: frequency_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:
//this module take 125Mhz input frequency and generate two output frequencies one is 2Hz and the other is 5Hz
//two input for this system the high frequency inoput and reset system 
//two output which are 2 clock one is 2 hz and the other is 5 Hz 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input Clock_in,
    input Reset,
    input en,
    output reg Clock_2kHz 
    );
    //defining two counters one for generating 2hz which is counter 1 and the other for generate 5Hz which is counter 2
    reg [2:0] counter2;
    reg [26:0] counter1; //as the maximum number that the counter will reach =(125*10^6/2)=62500000 so 25 bits is enough
    // PB in the board is connected with pull down resistance so it is always low and when you press it is high but we need the reverse effect 
    //here we synchoronize the design with the rising edge of the clock and the negative edge of not_reset
    always @(posedge Clock_in or negedge Reset)
    begin
    // if the reset is low make the two counters =0 and the two outputs =0 
     if(!Reset)
     begin
        counter1 <= 25'd0;
        Clock_2kHz <= 1'd0;

        end
        // if reset is high and the positive edge of the clock is positive increase each counter by 1 
      else 
      begin
        counter1 <= counter1 + 1;
        //if counter 1 reach 62500000 which represent half cycle of 2 Hz the 2Hz cloch is reversed and counter start counting again 
        if (counter1 == 26'd62500000)
            begin
                Clock_2kHz<=~Clock_2kHz;
                counter1 <= 25'd0;
             end
        
        end
        
end 

endmodule
