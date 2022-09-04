`timescale  1ns / 1ps

module n_bit_adder #(parameter WIDTH = 32) (A, B, Cin, Sum, Oflo);
 // the parameter default value is 32 
input [WIDTH-1:0] A, B; //input numbers 
input Cin;//carry input 
output [WIDTH-1:0] Sum; // the sum of the two numbers 
output Oflo; //sum overflow
wire [WIDTH:0] carry;
genvar i; /* the for index variable is declared as a genvar to
 be able to elaborate a for loop */
generate // generate … for statement
for (i = 0; i < WIDTH; i = i + 1)
    begin: adder_gen_block
    full_adder FA
    (.y(A[i]), .z(B[i]), .Ci(carry[i]),
    .S(Sum[i]), .Co(carry[i+1]));
    end
endgenerate
/* the following two continuous statements are for the
 initial carry input and the output overflow */
assign carry[0] = Cin;
assign Oflo = carry[WIDTH];
endmodule