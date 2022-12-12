module mux2 (
input in0, in1,
input s,
output out
);

assign out = s ? in1 : in0;


endmodule 