`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 09:17:09 PM
// Design Name: 
// Module Name: soda_machine_wrapper_fsm
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

// soda machine wrapper FSM
module soda_machine_wrapper_fsm(
    input clk,
    input nrst,
    input pb0,
    input sw3,
    input pb1,
    input pb2,
    input pb3,
    input disp,
    output reg start_disp,
    output reg [2:0] disp_data,
    output reg cost,
    output reg cost_add,
    output reg coins,
    output reg coins_add,
    output reg c_wrap
    );
    // counter used when you want to stay in a specific state so you can enable and wait for output 
 counter c1(
       .Clock_in(clk),
       .Reset(nrst),
       .en(en),
       .Clock_2kHz(value) 
    );
    wire value;
    reg en;
 
    reg [1:0] finish;
    reg [9:0] state, next_state;
// parameter declaration for one hot encoding
    parameter Init = 10'b0000000001, //inital state
              Cost_mode = 10'b0000000010,//starting detecting cost
              Cost_add = 10'b0000000100,//add the cost
              Cost_disp = 10'b0000001000,//display the cost 
              Price_mode = 10'b0000010000,// detects the coin
              Coins_add = 10'b0000100000,//add coins
              Total_disp = 10'b0001000000,//display the total coins
              Dispen = 10'b0010000000,//display dispence
              Flashing = 10'b0100000000,//blank
              Dispen2 = 10'b1000000000;//dispely second dispence 
     //state register       
    always@(posedge clk or negedge nrst)
        begin: STATE_REGISTER
            if (!nrst)
                state <= Init;
            else
                state <= next_state;
        end

    // state transitions
    always@ (state or pb0,sw3,pb1,pb2,pb3,disp,finish) 
        begin: Next_State_Logic
            case(state)
                Init: begin
                    if(sw3) begin next_state = Cost_mode;end
                    else   begin    next_state = Init;  end        
                end
                
                
                Cost_mode: begin
                   if      (pb0) begin  next_state = Init;        end
                   else if (pb1) begin  next_state = Cost_add;    end  
                   else if (pb3) begin  next_state = Cost_disp;   end
                   else if (~sw3)begin  next_state = Price_mode;  end
                   else          begin  next_state = Cost_mode;   end
                                         
               end    
 
                     
                     
                 Cost_add: begin
                    if(pb0) begin next_state = Init; end
                    else    begin next_state = Cost_mode; end 
                  end  
                       
                       
                       
                 Cost_disp: begin 
                    if(pb0) begin next_state = Init;      end
                    else    begin next_state = Cost_mode; end  
                 end
                 
                 
                  Price_mode: begin
                   if      (pb0)  begin next_state = Init;          end
                   else if (pb2)  begin next_state = Coins_add;     end
                   else if (pb3)  begin next_state = Total_disp;    end     
                   else if (sw3)  begin   next_state = Cost_mode;   end   
                   else if (disp) begin   next_state = Dispen;      end 
                   else           begin   next_state = Price_mode;  end         
                  end          
                                
                            
       
                Coins_add: begin
                    if      (pb0)  begin next_state = Init;          end
                    else if (disp) begin   next_state = Dispen;      end 
                    else           begin next_state =  Price_mode;   end
                    
                  end
                  
                  
                   Total_disp: begin 
                     if      (pb0)  begin next_state = Init;           end
                     else if (disp) begin   next_state = Dispen;      end 
                     else            begin next_state =  Price_mode;    end 
                 end

                 Dispen: begin
                     if      (~disp) begin en=1'b1; 
                     if (value == 1'b1 ) begin en=1'b0; next_state = Flashing;   end //wait for c
                     else begin next_state = Dispen; end
                     end
                     else   begin next_state = Dispen; end
                     

                 end
                 Flashing: begin  
                       if      (~disp) begin en=1'b1; 
                     if (value == 1'b0 ) begin en=1'b0; next_state = Dispen2;   end
                     else begin next_state = Flashing; end
                     end
                     else   begin next_state = Flashing; end       
                    end
                                
                   
                   Dispen2: begin
                     if      (~disp) begin en=1'b1; 
                     if (value == 1'b1 ) begin en=1'b0; next_state = Init;   end
                     else begin next_state = Dispen2; end
                     end
                     else   begin next_state = Dispen2; end   
                     end               
                    
                           
                 default: begin
                    next_state = Init;
                 end
        endcase
    end

//moore state output
    always@(state)
        begin: Moore_Outputs
        case (state)
            Init: begin
             start_disp =1'b1;
             disp_data =3'b001;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Cost_mode: begin
             start_disp =1'b0;
             disp_data =3'b000;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Cost_add: begin
             start_disp =1'b0;
             disp_data =3'b000;
             cost=1'b0;
             cost_add=1'b1;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Cost_disp: begin
             start_disp =1'b1;
             disp_data =3'b010;
             cost=1'b1;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Price_mode: begin
             start_disp =1'b0;
             disp_data =3'b000;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
           Coins_add: begin
             start_disp =1'b1;
             disp_data =3'b011;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b1;
             coins_add=1'b1;
             c_wrap =1'b1;
            end
            
            Total_disp: begin
             start_disp =1'b1;
             disp_data =3'b100;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end 
            
            Dispen: begin
             start_disp =1'b1;
             disp_data =3'b101;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Flashing: begin
             start_disp =1'b1;
             disp_data =3'b110;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            Dispen2: begin
             start_disp =1'b1;
             disp_data =3'b101;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end
            
            default:begin
             start_disp =1'b1;
             disp_data =3'b001;
             cost=1'b0;
             cost_add=1'b0;
             coins =1'b0;
             coins_add=1'b0;
             c_wrap =1'b0;
            end    
        endcase
    end
endmodule


