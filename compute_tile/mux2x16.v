module mux2x16 (
input [15:0] in0, in1,
input s,
output [15:0] out
);

mux2 m0(in0[0], in1[0], s, out[0]);
mux2 m1(in0[1], in1[1], s, out[1]);
mux2 m2(in0[2], in1[2], s, out[2]);
mux2 m3(in0[3], in1[3], s, out[3]);
mux2 m4(in0[4], in1[4], s, out[4]);
mux2 m5(in0[5], in1[5], s, out[5]);
mux2 m6(in0[6], in1[6], s, out[6]);
mux2 m7(in0[7], in1[7], s, out[7]);
mux2 m8(in0[8], in1[8], s, out[8]);
mux2 m9(in0[9], in1[9], s, out[9]);
mux2 m10(in0[10], in1[10], s, out[10]);
mux2 m11(in0[11], in1[11], s, out[11]);
mux2 m12(in0[12], in1[12], s, out[12]);
mux2 m13(in0[13], in1[13], s, out[13]);
mux2 m14(in0[14], in1[14], s, out[14]);
mux2 m15(in0[15], in1[15], s, out[15]);

endmodule 