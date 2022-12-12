module mux8x16 (
input [15:0] in0, in1, in2, in3, in4, in5, in6, in7,
input [2:0] s,
output [15:0] out
);

wire [15:0] muxOut0, muxOut1;

mux4x16 m0(in0, in1, in2, in3, s[1:0], muxOut0);
mux4x16 m1(in4, in5, in6, in7, s[1:0], muxOut1);
mux2x16 m2(muxOut0, muxOut1, s[2], out);


endmodule 