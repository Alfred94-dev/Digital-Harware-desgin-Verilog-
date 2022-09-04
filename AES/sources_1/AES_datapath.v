`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 10:47:15 PM
// Design Name: 
// Module Name: AES_datapath
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


module AES_datapath(
    input clk,nrst,load_nibble,load_shift,load_mix,load_key_generation,load_init_vector,load_key_init,load_adding_key,get_result,
    input [15:0] data_input,input_vector,key,
    input  [3:0] round_number,
    output reg [15:0] data_output,
    output reg finish,final_round,
    output reg  nibble_done,shift_done,mix_done,key_generation_done 
    );
    wire [15:0] save_out,key_out,nibble_out,generated_key,shift_out,Mix_out;
    reg [15:0] save_input,key_in;
    reg [3:0] round_num_input;
    wire [3:0] round_num_output;
    reg save_en,nibble_en,shift_en,RN_en,kg_en,kg_reg_en,mix_en;
    wire nibble_valid0,nibble_valid1,nibble_valid2,nibble_valid3,nibble_done1,key_generation_done1,shift_done1,mix_done1;
    n_bit_reg #(16)save(.D(save_input),.clk(clk),.en(save_en),.nrst(nrst),.Q(save_out));
//instantiate 4 nibble sub modules 
    NibbleSub ns0(.a(save_out[3:0]),.clk(clk),.en(nibble_en),.valid(nibble_valid0),.b(nibble_out[3:0]));
    NibbleSub ns1(.a(save_out[7:4]),.clk(clk),.en(nibble_en),.valid(nibble_valid1),.b(nibble_out[7:4]));
    NibbleSub ns2(.a(save_out[11:8]),.clk(clk),.en(nibble_en),.valid(nibble_valid2),.b(nibble_out[11:8]));
    NibbleSub ns3(.a(save_out[15:12]),.clk(clk),.en(nibble_en),.valid(nibble_valid3),.b(nibble_out[15:12]));
    
    n_bit_reg #(4)RN(.D(round_num_input),.clk(clk),.en(RN_en),.nrst(nrst),.Q(round_num_output));
    
    n_bit_reg #(16)kg(.D(key_in),.clk(clk),.en(kg_reg_en),.nrst(nrst),.Q(key_out));
//instantiate keygeneration module 
    key_generation gn(.clk(clk),.nrst(nrst),.load(kg_en),.round_num(round_num_output),.key(key_out),.round1(generated_key),.done(key_generation_done1));
    //instantiate shiftrowmodule 
    shiftRow sr0(.b(save_out),.clk(clk),.en(shift_en),.valid(shift_done1),.c(shift_out));

    
    assign nibble_done1= nibble_valid0 & nibble_valid1 & nibble_valid2 & nibble_valid3;
     
    //instantiate mixcolumn module 
    Mix_column mx1(.clk(clk),.nrst(nrst),.c0(save_out[15:12]),.c1(save_out[11:8]),.c2(save_out[7:4]),.c3(save_out[3:0]),
    .load(mix_en),.d0(Mix_out[15:12]),.d1(Mix_out[11:8]),.d2(Mix_out[7:4]),.d3(Mix_out[3:0]),.done(mix_done1));


    always@(load_nibble,load_shift,load_mix,load_key_generation,load_init_vector,load_key_init,load_adding_key,get_result, nibble_done1,shift_done1,mix_done1,key_generation_done1)
    begin 
        if (load_init_vector) begin
           save_input= data_input ^ input_vector;
           round_num_input=4'b0000;
           key_in=16'b0000000000000000;
           data_output=16'b0000000000000000;
           save_en=1'b1;
           RN_en=1'b0;
           kg_reg_en=1'b0;
           nibble_en=1'b0;
           shift_en=1'b0;
           kg_en=1'b0;
           mix_en=1'b0;
           finish=1'b0;
           final_round=1'b0;
           nibble_done=1'b0;
           shift_done=1'b0;
           mix_done=1'b0;
           key_generation_done=1'b0;
        end
        else if (load_key_init)begin
           save_input= save_out ^ key;
           round_num_input=4'b0000;
           key_in=key;
           data_output=16'b0000000000000000;
           save_en=1'b1;
           RN_en=1'b1;
           kg_reg_en=1'b1; //enable key generation module 
           nibble_en=1'b0;
           shift_en=1'b0;
           kg_en=1'b0;
           mix_en=1'b0;
           finish=1'b0;
           final_round=1'b0;
           nibble_done=1'b0;
           shift_done=1'b0;
           mix_done=1'b0;
           key_generation_done=1'b0;
           
        end
        
        else if (nibble_done1) begin
         save_input= nibble_out;
         round_num_input=round_num_output+4'b0001;
         key_in=16'b0000000000000000;
         save_en=1'b1;
         RN_en=1'b1;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         final_round=1'b0;
         nibble_done=1'b1; 
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0;
        end
        else if (load_nibble) begin 
         save_input= nibble_out;
         round_num_input=round_num_output+4'b0001;
         key_in=16'b0000000000000000;
         save_en=1'b0;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b1; //enable nibble sub module 
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         final_round=1'b0;
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0;
        end
        
         else if (key_generation_done1) begin
         save_input= shift_out;
         round_num_input=4'b0000;
         key_in=generated_key;
         data_output=16'b0000000000000000;
         save_en=1'b0;
         RN_en=1'b0;
         kg_reg_en=1'b1;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         if (round_num_output == round_number) begin final_round=1'b1; end 
         else begin final_round=1'b0; end 
         nibble_done=1'b0;
         shift_done=1'b1;
         mix_done=1'b0;
         key_generation_done=1'b1; 
        end
        
        else if (load_adding_key) begin 
         save_input= key_out ^ save_out;
         round_num_input=4'b0000;
         key_in=16'b0000000000000000;
         data_output=16'b0000000000000000;
         save_en=1'b1;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         if (round_num_output == round_number) begin final_round=1'b1; end 
         else begin final_round=1'b0; end
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0; 
        end
        
         else if (shift_done1) begin
         save_input= shift_out;
         round_num_input=4'b0000;
         key_in=16'b0000000000000000;
         save_en=1'b1;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         if (round_num_output == round_number) begin final_round=1'b1; end 
         else begin final_round=1'b0; end 
         nibble_done=1'b0;
         shift_done=1'b1;
         mix_done=1'b0;
         key_generation_done=1'b0; 
        end
        
        else if (load_shift& load_key_generation) begin
         save_input= shift_out;
         round_num_input=4'b0000;
         key_in=generated_key;
         data_output=16'b0000000000000000;
         save_en=1'b0;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b1; //enable shift module 
         kg_en=1'b1;
         mix_en=1'b0;
         finish=1'b0;
         if (round_num_output == round_number) begin final_round=1'b1; end 
         else begin final_round=1'b0; end
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0; 
        end
        
         else if (mix_done1) begin 
         save_input= Mix_out;
         round_num_input=4'b0000;
         key_in=16'b0000000000000000;
         data_output=16'b0000000000000000;
         save_en=1'b1;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b0;
         final_round=1'b0;
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b1;
         key_generation_done=1'b0; 
        end
        
        else if (load_mix) begin 
         save_input= Mix_out;
         round_num_input=4'b0000;
         key_in=16'b0000000000000000;
         data_output=16'b0000000000000000;
         save_en=1'b0;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b1;
         finish=1'b0;
         final_round=1'b0;
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0; 
        end
        

        
        else if(get_result) begin 
         save_input= 16'b0000000000000000;
         round_num_input=4'b0000;
         key_in=16'b0000000000000000;
         save_en=1'b0;
         RN_en=1'b0;
         kg_reg_en=1'b0;
         nibble_en=1'b0;
         shift_en=1'b0;
         kg_en=1'b0;
         mix_en=1'b0;
         finish=1'b1;
         data_output=save_out;
         final_round=1'b0;
         nibble_done=1'b0;
         shift_done=1'b0;
         mix_done=1'b0;
         key_generation_done=1'b0; 
        end 
    end 
endmodule
