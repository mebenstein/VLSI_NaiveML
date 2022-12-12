module reg8 (
input enable, clear, clk,
input [7:0] dataIn,
output [7:0] dataOut
);

reg [7:0] regValue;

assign dataOut = regValue;

always @(posedge clk)
if (~clear) begin
  regValue <= 8'b0;
end else if (enable) begin
  regValue <= dataIn;
end

endmodule 