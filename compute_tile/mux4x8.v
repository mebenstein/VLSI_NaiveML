module mux4x8 (
input [7:0] in0, in1, in2, in3,
input [1:0] s,
output [7:0] out
);

wire [7:0] muxOut0, muxOut1;

mux2x8 m0(in0, in1, s[0], muxOut0);
mux2x8 m1(in2, in3, s[0], muxOut1);
mux2x8 m2(muxOut0, muxOut1, s[1], out);

endmodule 