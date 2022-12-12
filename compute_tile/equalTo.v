module equalTo(
input [15:0] a, b,
output [15:0] out
);

wire signed [15:0] signed_a, signed_b;

assign signed_a = a;
assign signed_b = b;

assign out[15:1] = 15'b0;
assign out[0] = a == b;

endmodule