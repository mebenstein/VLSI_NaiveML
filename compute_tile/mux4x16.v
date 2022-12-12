module mux4x16 (
input [15:0] in0, in1, in2, in3,
input [1:0] s,
output [15:0] out
);

wire [15:0] muxOut0, muxOut1;

mux2x16 m0(in0, in1, s[0], muxOut0);
mux2x16 m1(in2, in3, s[0], muxOut1);
mux2x16 m2(muxOut0, muxOut1, s[1], out);

endmodule 