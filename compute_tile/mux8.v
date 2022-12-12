module mux8 (
input [7:0] in,
input [2:0] s,
output out
);

wire muxout0, muxout1;

mux4 m0(in[3:0], s[1:0], muxout0);
mux4 m1(in[7:4], s[1:0], muxout1);
mux2 m2(muxout0, muxout1, s[2], out);


endmodule 