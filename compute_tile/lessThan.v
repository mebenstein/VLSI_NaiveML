module lessThan(
input minMode,
input [15:0] a, b,
output [15:0] out
);

reg [15:0] compareOut;
wire signed [15:0] signed_a, signed_b;

assign signed_a = a;
assign signed_b = b;

assign out = minMode ? compareOut : {15'b0, a < b};

always@* begin
    if(signed_a < signed_b) begin
        compareOut <= a;
    end else begin
        compareOut <= b;
    end
end

endmodule