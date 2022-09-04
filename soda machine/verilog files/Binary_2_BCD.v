`timescale 1ns/ 1ps 
module Binary_2_BCD (output [9:0] bcd,  input [7:0] bin);
wire [2:0] c1_c2,c2_c3,c3_c4,c4_c5,c6_c7;
wire c1_c6_1,c2_c6_1,c3_c6_1,c4_c7_1;

assign bcd[0]=bin[0];
Bcd_con c1(.A({1'b0,bin[7:5]}),.S({c1_c6_1,c1_c2[2:0]}));
Bcd_con c2(.A({c1_c2[2:0],bin[4]}),.S({c2_c6_1,c2_c3[2:0]}));
Bcd_con c3(.A({c2_c3[2:0],bin[3]}),.S({c3_c6_1,c3_c4[2:0]}));
Bcd_con c4(.A({c3_c4[2:0],bin[2]}),.S({c4_c7_1,c4_c5[2:0]}));
Bcd_con c5(.A({c4_c5[2:0],bin[1]}),.S(bcd[4:1]));
Bcd_con c6(.A({1'b0,c1_c6_1,c2_c6_1,c3_c6_1}),.S({bcd[9],c6_c7[2:0]}));
Bcd_con c7(.A({c6_c7[2:0],c4_c7_1}),.S(bcd[8:5]));
endmodule 
