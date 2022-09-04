`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 06:58:01 PM
// Design Name: 
// Module Name: AES_wrapper_FSM
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


module AES_wrapper_FSM(
    input clk,nrst,pb1_pulse,pb3_pulse,finished,
    output reg v0,v1,v2,v3,m0,m1,m2,m3,k0,k1,k2,k3,ron,start_enc,disp
    );
    reg [18:0] state, next_state;
// parameter declaration for one hot encoding
    parameter Init = 19'b0000000000000000001, //inital state
              Vector0 = 19'b0000000000000000010,
              Vector1 = 19'b0000000000000000100,
              Vector2 = 19'b0000000000000001000,
              Vector3= 19'b0000000000000010000,
              Message_mode= 19'b0000000000000100000,
              Message0=19'b0000000000001000000,
              Message1= 19'b0000000000010000000,
              Message2= 19'b0000000000100000000,
              Message3= 19'b0000000001000000000,
              Key_mode= 19'b0000000010000000000,
              Key0= 19'b0000000100000000000,
              Key1= 19'b0000001000000000000,
              Key2= 19'b0000010000000000000,
              Key3= 19'b0000100000000000000,
              Round= 19'b0001000000000000000,
              Encrypt= 19'b0010000000000000000,
              Output_data= 19'b0100000000000000000,
              Display= 19'b1000000000000000000;
     //state register       
    always@(posedge clk or negedge nrst)
        begin: STATE_REGISTER
            if (!nrst)
                state <= Init;
            else
                state <= next_state;
        end

    // state transitions
    always@ (state or pb1_pulse,pb3_pulse,finished) 
        begin: Next_State_Logic
            case(state)
                Init: begin
                    if(pb1_pulse)        begin next_state = Vector0;      end
                    else            begin next_state = Init;    end         
                end
                
                
                Vector0: begin
                    if(pb1_pulse)        begin next_state = Vector1;      end
                    else            begin next_state = Vector0;    end   
                                         
               end    
   
                 Vector1: begin
                    if(pb1_pulse)        begin next_state = Vector2;      end
                    else            begin next_state = Vector1;    end   
                                         
               end 
               
               Vector2: begin
                    if(pb1_pulse)        begin next_state = Vector3;      end
                    else            begin next_state = Vector2;    end   
                                         
               end
               Vector3: begin
                    if(pb3_pulse)        begin next_state = Message_mode;  end
                    else            begin next_state = Vector3;    end   
               end 
               Message_mode: begin
                    if(pb1_pulse)        begin next_state = Message0;  end
                    else            begin next_state = Message_mode;    end   
               end        
               Message0: begin
                    if(pb1_pulse)        begin next_state = Message1;  end
                    else            begin next_state = Message0;    end   
               end
               Message1: begin
                    if(pb1_pulse)        begin next_state = Message2;  end
                    else            begin next_state = Message1;    end   
               end
               Message2: begin
                    if(pb1_pulse)        begin next_state = Message3;  end
                    else            begin next_state = Message2;    end   
               end
               Message3: begin
                    if(pb3_pulse)        begin next_state = Key_mode;  end
                    else            begin next_state = Message3;    end   
               end
               Key_mode: begin
                    if(pb1_pulse)        begin next_state = Key0;  end
                    else            begin next_state = Key_mode;    end   
               end
               Key0: begin
                    if(pb1_pulse)        begin next_state = Key1;  end
                    else            begin next_state = Key0;    end   
               end
               Key1: begin
                    if(pb1_pulse)        begin next_state = Key2;  end
                    else            begin next_state = Key1;    end   
               end
               Key2: begin
                    if(pb1_pulse)        begin next_state = Key3;  end
                    else            begin next_state = Key2;    end   
               end 
               Key3: begin
                    if(pb3_pulse)        begin next_state = Round;  end
                    else            begin next_state = Key3;    end   
               end 
               
               Round: begin
                    if(pb3_pulse)        begin next_state = Encrypt;  end
                    else            begin next_state = Round;    end   
               end
               
               Encrypt: begin
                    if(finished)        begin next_state = Output_data;  end
                    else            begin next_state = Encrypt;    end   
               end
               
               Output_data: begin
                     next_state = Display;       
               end
               
               Display: begin
                    next_state = Display;       
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
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Vector0: begin
               v0 =1'b1;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Vector1: begin
               v0 =1'b0;
               v1 =1'b1;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Vector2: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b1;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Vector3: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b1;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Message_mode: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Message0: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b1;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Message1: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b1;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Message2: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b1;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Message3: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b1;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Key_mode: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Key0: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b1;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Key1: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b1;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Key2: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b1;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Key3: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b1;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Round: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b1;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Encrypt: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b1;
               disp =1'b0;
            end
            
            Output_data: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end
            
            Display: begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b1;

            end
            
            
            
            default:begin
               v0 =1'b0;
               v1 =1'b0;
               v2 =1'b0;
               v3 =1'b0;
               m0 =1'b0;
               m1 =1'b0;
               m2 =1'b0;
               m3 =1'b0;
               k0 =1'b0;
               k1 =1'b0;
               k2 =1'b0;
               k3 =1'b0;
               ron =1'b0;
               start_enc =1'b0;
               disp =1'b0;
            end    
        endcase
    end


endmodule
