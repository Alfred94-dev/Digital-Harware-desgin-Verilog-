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


module frequency_divider(
    input Clock_in,
    input Reset,
    output reg Clock_2Hz,
    output reg Clock_5Hz
    );
    //defining two counters one for generating 2hz which is counter 1 and the other for generate 5Hz which is counter 2
    reg [25:0] counter1; //as the maximum number that the counter will reach =(125*10^6/4)-1=31249999 so 25 bits is enough
    reg [24:0] counter2; //as the maximum number that the counter will reach =(125*10^6/10)-1=12499999 so 25 bits is enough
    // PB in the board is connected with pull down resistance so it is always low and when you press it is high but we need the reverse effect 
    //it is always high and when we press it is low so we will use not gate 
    wire Not_reset;
    assign Not_reset=~Reset;
    //here we synchoronize the design with the rising edge of the clock and the negative edge of not_reset
    always @(posedge Clock_in or negedge Not_reset)
    begin
    // if the reset is low make the two counters =0 and the two outputs =0 
     if(!Not_reset)
     begin
        counter1 <= 25'd0;
        counter2 <= 24'd0;
        Clock_2Hz <= 1'd0;
        Clock_5Hz <= 1'd0;
        end
        // if reset is high and the positive edge of the clock is positive increase each counter by 1 
      else
      begin
        counter1 <= counter1 + 1;
        counter2 <= counter2 + 1;
        //if counter 1 reach 31249999 which represent half cycle of 2 Hz the 2Hz cloch is reversed and counter start counting again 
        if (counter1 == 25'd31249999)
            begin
                Clock_2Hz<=~Clock_2Hz;
                counter1 <= 25'd0;
             end
         //if counter 2 reach 12499999 which represent half cycle of 5 Hz the 5Hz cloch is reversed and counter start counting again
        if (counter2 == 24'd12499999)
            begin
                Clock_5Hz<=~Clock_5Hz;
                counter2 <= 24'd0;
            end
        end
end 

endmodule
