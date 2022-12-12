module mux4 (
input [3:0] in,
input [1:0] s,
output out
);

wire muxout0, muxout1;

mux2 m0(in[0], in[1], s[0], muxout0);
mux2 m1(in[2], in[3], s[0], muxout1);
mux2 m2(muxout0, muxout1, s[1], out);


endmodule 