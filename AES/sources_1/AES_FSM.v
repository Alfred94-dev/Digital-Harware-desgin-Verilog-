`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 10:47:15 PM
// Design Name: 
// Module Name: AES_FSM
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


module AES_FSM(
    input clk,nrst,nibble_done,shift_done,mix_done,key_generation_done,final_round,load,
    output reg load_nibble,load_shift,load_mix,load_key_generation,load_init_vector,load_key_init,load_adding_key,get_result
    );
    reg [8:0] state, next_state;
// parameter declaration for one hot encoding
    parameter Init = 9'b000000001, //inital state
              Vector_init = 9'b000000010,//vector initializtion
              Init_key = 9'b000000100,//round 0 key 
              Nibble_sub = 9'b000001000, //nibble sub state
              Shift_row= 9'b000010000, //shiftrow state 
              Mix_column= 9'b000100000, //mixcolumn state
              Add_key=9'b001000000, // add round key state 
              Get_encrypted= 9'b010000000, //get the encrypted message 
              Delay= 9'b100000000;
     //state register       
    always@(posedge clk or negedge nrst)
        begin: STATE_REGISTER
            if (!nrst)
                state <= Init;
            else
                state <= next_state;
        end

    // state transitions
    always@ (state or load,nibble_done,shift_done,mix_done,key_generation_done,final_round) 
        begin: Next_State_Logic
            case(state)
                Init: begin
                    if(load)        begin next_state = Vector_init;      end
                    else            begin next_state = Init;    end         
                end
                
                
                Vector_init: begin
                    next_state = Init_key;   
                                         
               end    
   
                 Init_key: begin
                    next_state = Nibble_sub;   
                  end  
                       
                 Nibble_sub: begin 
                    if(nibble_done)        begin next_state = Shift_row;      end
                    else            begin next_state = Nibble_sub;    end  
                 end
                 
                 
                  Shift_row: begin
                     if (shift_done & (~final_round) & key_generation_done)   begin next_state = Mix_column;      end
                    else if (shift_done & (final_round)& key_generation_done) begin next_state = Delay;      end
                    else        begin next_state = Shift_row;    end            
                  end 
                  
                  Mix_column: begin
                     if(mix_done)        begin next_state = Add_key;      end
                     else                begin next_state = Mix_column;   end            
                  end  
                  
                  Add_key: begin 
                    if (~final_round)     begin next_state = Nibble_sub;      end
                    else if (final_round) begin next_state = Get_encrypted;   end
                    else                  begin next_state = Add_key;         end  
                 end       
                  
                  Get_encrypted: begin
                     next_state = Get_encrypted;           
                  end 
                  Delay: begin
                     next_state = Add_key;           
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
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0; 
               
            end
            
            Vector_init: begin
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b1;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0; 
            end
            
            Init_key: begin
              load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b1;
               load_adding_key=1'b0;
               get_result=1'b0;  
            end
            
            Nibble_sub: begin
               load_nibble=1'b1;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0;
            end
            
            Shift_row: begin
               load_nibble=1'b0;
               load_shift=1'b1;
               load_mix=1'b0;
               load_key_generation=1'b1;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0;
            end
            
            
            Mix_column: begin
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b1;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0;
            end
            
            
            Add_key: begin
                load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b1;
               get_result=1'b0;
            end
            
            
            Get_encrypted: begin
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b1;  
            end
            
            Delay:begin
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0;
            end    

            default:begin
               load_nibble=1'b0;
               load_shift=1'b0;
               load_mix=1'b0;
               load_key_generation=1'b0;
               load_init_vector=1'b0;
               load_key_init=1'b0;
               load_adding_key=1'b0;
               get_result=1'b0;
            end    
        endcase
    end
endmodule
