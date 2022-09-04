`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 10:47:15 PM
// Design Name: 
// Module Name: AES
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


module AES(
    input clk,nrst,load, 
    input [15:0] data_input,input_vector,key, //input data,key,initilzationvector
    input  [3:0] round_number, //number of rounds 
    output [15:0] data_output, //encrypted data
    output finish //flag to indicate finishing encryption
    );
    wire load_nibble,load_shift,load_mix,load_key_generation,load_init_vector,load_key_init;
    wire load_adding_key,get_result,nibble_done,shift_done,mix_done,key_generation_done,final_round;
//instantiate datapath
    AES_datapath dp1(
    .clk(clk),
    .nrst(nrst),
    .load_nibble(load_nibble),
    .load_shift(load_shift),
    .load_mix(load_mix),
    .load_key_generation(load_key_generation),
    .load_init_vector(load_init_vector),
    .load_key_init(load_key_init),
    .load_adding_key(load_adding_key),
    .get_result(get_result),
    .data_input(data_input),
    .input_vector(input_vector),
    .key(key),
    .round_number(round_number),
    .data_output(data_output),
    .finish(finish),
    .nibble_done(nibble_done),
    .shift_done(shift_done),
    .mix_done(mix_done),
    .key_generation_done(key_generation_done),
    .final_round(final_round) 
    );
//instantiate FSM
    AES_FSM fs1(
    .clk(clk),
    .nrst(nrst),
    .nibble_done(nibble_done),
    .shift_done(shift_done),
    .load(load),
    .mix_done(mix_done),
    .key_generation_done(key_generation_done),
    .final_round(final_round),
    .load_nibble(load_nibble),
    .load_shift(load_shift),
    .load_mix(load_mix),
    .load_key_generation(load_key_generation),
    .load_init_vector(load_init_vector),
    .load_key_init(load_key_init),
    .load_adding_key(load_adding_key),
    .get_result(get_result)
    );
endmodule
