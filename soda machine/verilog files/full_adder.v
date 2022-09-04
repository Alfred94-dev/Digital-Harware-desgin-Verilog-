`timescale  1ns / 1ps
module full_adder(
input y,z,Ci,
output S,Co
);
wire x1,x2,x3;
assign S =y^z^Ci;
assign x1= y & z;
assign x2= y & Ci;
assign x3= z & Ci;
assign Co = x1 | x2 | x3;
endmodule


