module mux2x8 (
input [7:0] in0, in1,
input s,
output [7:0] out
);

mux2 m0(in0[0], in1[0], s, out[0]);
mux2 m1(in0[1], in1[1], s, out[1]);
mux2 m2(in0[2], in1[2], s, out[2]);
mux2 m3(in0[3], in1[3], s, out[3]);
mux2 m4(in0[4], in1[4], s, out[4]);
mux2 m5(in0[5], in1[5], s, out[5]);
mux2 m6(in0[6], in1[6], s, out[6]);
mux2 m7(in0[7], in1[7], s, out[7]);


endmodule 