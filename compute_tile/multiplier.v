module multiplier (
input [15:0] a, b,
output [15:0] out
);

wire signed [15:0] signed_a, signed_b;

assign signed_a = a;
assign signed_b = b;

assign out = signed_a*signed_b;

endmodule 