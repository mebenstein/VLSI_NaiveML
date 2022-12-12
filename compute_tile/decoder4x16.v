module decoder4x16 (
input [3:0] in,
output [15:0] out
);
 
assign out[15] = in[0] & in[1] & in[2] & in[3];
assign out[14] = ~in[0] & in[1] & in[2] & in[3];
assign out[13] = in[0] & ~in[1] & in[2] & in[3];
assign out[12] = ~in[0] & ~in[1] & in[2] & in[3];
assign out[11] = in[0] & in[1] & ~in[2] & in[3];
assign out[10] = ~in[0] & in[1] & ~in[2] & in[3];
assign out[9] = in[0] & ~in[1] & ~in[2] & in[3];
assign out[8] = ~in[0] & ~in[1] & ~in[2] & in[3];
assign out[7] = in[0] & in[1] & in[2] & ~in[3];
assign out[6] = ~in[0] & in[1] & in[2] & ~in[3];
assign out[5] = in[0] & ~in[1] & in[2] & ~in[3];
assign out[4] = ~in[0] & ~in[1] & in[2] & ~in[3];
assign out[3] = in[0] & in[1] & ~in[2] & ~in[3];
assign out[2] = ~in[0] & in[1] & ~in[2] & ~in[3];
assign out[1] = in[0] & ~in[1] & ~in[2] & ~in[3];
assign out[0] = ~in[0] & ~in[1] & ~in[2] & ~in[3];

endmodule 