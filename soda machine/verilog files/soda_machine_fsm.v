`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2019 06:02:11 PM
// Design Name: 
// Module Name: soda_machine_fsm
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

// module used to define soda machine datapath
module soda_machine_fsm(
    input clk_1,
    input nrst,
    input c_1,
    input tot_lt_s_1,
    input s_eq_zero_1,
    output reg d_1,
    output reg tot_ld_1,
    output reg tot_clr_1
    );
    reg [3:0] state, next_state;//four state so we need state to be four bit
// parameter declaration for one hot encoding
    parameter Init = 4'b0001, //define first state 
              Wait = 4'b0010,//define second state
              Add = 4'b0100,//define third state
              Disp = 4'b1000; //define fourth state
    always@(posedge clk_1 or negedge nrst) //always block active at rising edge or asynchronous reset
        begin: STATE_REGISTER
            if (!nrst)
                state <= Init; //if reset hapened start from the init state
            else
                state <= next_state; //at each rising edge go for transition
        end

// always block control transitions between states 
    always@ (state or c_1 or tot_lt_s_1 or s_eq_zero_1) 
        begin: Next_State_Logic
            case(state)
                Init: begin 
                    next_state = Wait; //after being in first state directly go to wait state 
                end
                Wait: begin
                   if(s_eq_zero_1) 
                       begin
                         next_state = Wait; // if cost equal 0 stay in the wait state
                       end
                    else //if cost not equal zero
                    begin     
                        if (c_1) begin
                            next_state = Add; // if c=1 goto add state
                        end
                        else //if c=0
                        begin
                            if (~tot_lt_s_1) begin //if total larger than cost go to fourth state 
                                next_state = Disp;
                            end
                            else 
                            begin
                                next_state = Wait; //if nothing happened stay in the wait state
                            end
                          end
                        end  
                    end   
                 Add: begin
                    next_state = Wait; //if you are in the add state directly go to wait state 
                 end
                 Disp: begin 
                     next_state = Init;  //if you are in dispenced state so it dispenced so go back to ready state
                 end
                 default: begin
                    next_state = Wait; //default is the same as the init state
                 end
        endcase
    end

//always block for generating the output at each state
    always@(state)
        begin: Moore_Outputs
        case (state)
            Init: begin
                d_1 = 1'b0;
                tot_clr_1 = 1'b1; //in init state this output used to clear the value of coins stored in the datapath
                tot_ld_1 = 1'b0;
            end
            Wait: begin //in wait state you are waiting for coins so all outputs equal zero
                d_1 = 1'b0;
                tot_clr_1 = 1'b0;
                tot_ld_1= 1'b0;
            end
            Add: begin //the add state output is used to load a new coin and add it 
                d_1 = 1'b0;
                tot_clr_1 = 1'b0;
                tot_ld_1 = 1'b1; 
            end
            Disp: begin//in the dispence state which means coins larger than cost so dispence =1
                d_1 = 1'b1;
                tot_clr_1 = 1'b0;
                tot_ld_1 =  1'b0;
            end
            default:begin // default state is the same as transition state
                d_1 = 1'b0;
                tot_clr_1 = 1'b1;
                tot_ld_1 = 1'b0;
            end    
        endcase
    end
endmodule
