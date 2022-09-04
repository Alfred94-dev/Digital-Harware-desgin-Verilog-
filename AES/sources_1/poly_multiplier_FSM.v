`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2019 03:38:51 PM
// Design Name: 
// Module Name: poly_multiplier_FSM
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


module poly_multiplier_FSM(
    input clk,nrst,load,MCD_eq_zero,MCD_LSB,MPR_fifth,
    output reg en_MPR,en_MCD,en_Rslt,MCD_check, MCD_LSB_check,calc_res,MPR_shift,MPR_check,calc_MPR,MCD_shift,final_result
    );
    reg [9:0] state, next_state;
// parameter declaration for one hot encoding
    parameter Init = 10'b0000000001, //inital state
              Load = 10'b0000000010,//load values of registers 
             Check_MCD_zero = 10'b0000000100,//check if MCD reg=0
             Check_MCD_LSB = 10'b0000001000,//check if MCD reg lsb=1
              Set_result= 10'b0000010000,//set the value of result register
              Shift_MPR= 10'b0000100000,// shift left MPR register
              Check_MPR_fifth=10'b0001000000,//check the fifth bit of MPR
              Set_MPR= 10'b0010000000,//set new value of mpr
              Shift_MCD=10'b0100000000,//shift mcd reg right
              Get_result=10'b1000000000;
              
     //state register       
    always@(posedge clk or negedge nrst)
        begin: STATE_REGISTER
            if (!nrst)
                state <= Init;
            else
                state <= next_state;
        end

    // state transitions
    always@ (state or load,MCD_eq_zero,MCD_LSB,MPR_fifth) 
        begin: Next_State_Logic
            case(state)
                Init: begin
                      if      (load==1'b1) begin  next_state = Load;  end
                      else                  begin  next_state = Init;        end
                end
                
                
                Load: begin
                    next_state = Check_MCD_zero;   
                                         
               end    
 
                     
                     
                 Check_MCD_zero: begin
                    if(MCD_eq_zero) begin next_state = Get_result; end
                    else if(~MCD_eq_zero) begin next_state = Check_MCD_LSB; end
                    else                  begin next_state = Check_MCD_zero; end 
                  end  
                       
                       
                       
                 Check_MCD_LSB: begin 
                    if(MCD_LSB)        begin next_state = Set_result;      end
                    else if (~MCD_LSB) begin next_state = Shift_MPR;      end
                    else            begin next_state = Check_MCD_LSB;    end  
                 end
                 
                 
                  Set_result: begin
                     next_state = Shift_MPR;           
                  end 
                  
                  Shift_MPR: begin
                     next_state = Check_MPR_fifth;           
                  end  
                  
                  Check_MPR_fifth: begin 
                    if (MPR_fifth)        begin next_state = Set_MPR;      end
                    else if (~MPR_fifth) begin next_state = Shift_MCD;      end
                    else            begin next_state = Check_MPR_fifth;    end  
                 end       
                  
                  Set_MPR: begin
                     next_state = Shift_MCD;           
                  end 
                  
                  Shift_MCD: begin
                     next_state = Check_MCD_zero;           
                  end
                  
                 Get_result: begin
                     if      (load==1'b1) begin  next_state = Get_result;  end
                      else                  begin  next_state = Init;        end          
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
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            Load: begin
                en_MPR=1'b1;
                en_MCD=1'b1;
                en_Rslt=1'b1;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            Check_MCD_zero: begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b1; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            Check_MCD_LSB: begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b1;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            Set_result: begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b1;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b1;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            
            Shift_MPR: begin
                en_MPR=1'b1;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b1;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            
            Check_MPR_fifth: begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b1;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            
            Set_MPR: begin
                en_MPR=1'b1;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b1;
                MCD_shift=1'b0;
                final_result=1'b0;
            end
            
            Shift_MCD: begin
                en_MPR=1'b0;
                en_MCD=1'b1;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b1;
                final_result=1'b0;
            end
            
            
            Get_result: begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b1;
            end

            default:begin
                en_MPR=1'b0;
                en_MCD=1'b0;
                en_Rslt=1'b0;
                MCD_check=1'b0; 
                MCD_LSB_check=1'b0;
                calc_res=1'b0;
                MPR_shift=1'b0;
                MPR_check=1'b0;
                calc_MPR=1'b0;
                MCD_shift=1'b0;
                final_result=1'b0;
            end    
        endcase
    end
endmodule


