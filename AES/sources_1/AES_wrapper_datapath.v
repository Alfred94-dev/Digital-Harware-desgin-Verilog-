`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 06:58:01 PM
// Design Name: 
// Module Name: AES_wrapper_datapath
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


module AES_wrapper_datapath(
    input clk,nrst,v0,v1,v2,v3,m0,m1,m2,m3,k0,k1,k2,k3,ron,start_enc,disp,
    input [3:0] sw,
    output finished,
    output reg oled_enc,
    output [7:0] s0,s1,s2,s3
    );
    reg load;
    reg [15:0] vec_input, message_input,key_input;
    reg [3:0] round_input;
    reg  vec_en, message_en,key_en,round_en;
    wire [15:0] vec_output, message_output,key_output,encrypted_message;
    wire [3:0] round_output;
    AES aes1(
    .clk(clk),
    .nrst(nrst),
    .load(load), 
    .data_input(message_output),
    .input_vector(vec_output),
    .key(key_output),
    .round_number(round_output),
    .data_output(encrypted_message),
    .finish(finished)
    );
    
    n_bit_reg #(16)vecR(.D(vec_input),.clk(clk),.en(vec_en),.nrst(nrst),.Q(vec_output));
    n_bit_reg #(16)messageR(.D(message_input),.clk(clk),.en(message_en),.nrst(nrst),.Q(message_output));
    n_bit_reg #(16)keyR(.D(key_input),.clk(clk),.en(key_en),.nrst(nrst),.Q(key_output));
    n_bit_reg #(4)roundR(.D(round_input),.clk(clk),.en(round_en),.nrst(nrst),.Q(round_output));
    
    
    bin_asci b1(.bin(encrypted_message[3:0]),.hex(s0));
    bin_asci b2(.bin(encrypted_message[7:4]),.hex(s1));
    bin_asci b3(.bin(encrypted_message[11:8]),.hex(s2));
    bin_asci b4(.bin(encrypted_message[15:12]),.hex(s3));
    ila_0 (
.clk(clk),
.probe0(message_output),
.probe1(key_output),
.probe2(vec_output),
.probe3(encrypted_message),
.probe4(round_output)
);
    always@(v0,v1,v2,v3,m0,m1,m2,m3,k0,k1,k2,k3,ron,start_enc,disp)
        begin
            if (v0) begin
                load=1'b0;
                vec_input={12'b000000000000,sw};
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b1;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end 
            else if (v1) begin
                load=1'b0;
                vec_input={6'b000000,sw,vec_output[3:0]};
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b1;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (v2) begin 
                load=1'b0;
                vec_input={3'b000,sw,vec_output[7:0]};
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b1;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (v3) begin 
                load=1'b0;
                vec_input={sw,vec_output[11:0]};
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b1;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (m0) begin
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input={12'b000000000000,sw};
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b1;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0; 
            end
            else if (m1) begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input={6'b000000,sw,message_output[3:0]};
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b1;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (m2) begin
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input={3'b000,sw,message_output[7:0]};
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b1;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0; 
            end
            else if (m3) begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input={sw,message_output[11:0]};
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b1;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (k0) begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input={12'b000000000000,sw};
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b1;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (k1) begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input={6'b000000,sw,key_output[3:0]};
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b1;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (k2) begin
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input={3'b000,sw,key_output[7:0]};
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b1;
                round_en=1'b0;
                oled_enc=1'b0; 
            end
            else if (k3) begin
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input={sw,key_output[11:0]};
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b1;
                round_en=1'b0;
                oled_enc=1'b0; 
            end
            else if (ron) begin
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=sw;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b1;
                oled_enc=1'b0; 
            end
            else if (start_enc) begin 
                load=1'b1;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
            else if (disp) begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b1;
            end
      
          
            else begin 
                load=1'b0;
                vec_input=16'b0000000000000000;
                message_input=16'b0000000000000000;
                key_input=16'b0000000000000000;
                round_input=4'b0000;
                vec_en=1'b0;
                message_en=1'b0;
                key_en=1'b0;
                round_en=1'b0;
                oled_enc=1'b0;
            end
        end 
    
endmodule
