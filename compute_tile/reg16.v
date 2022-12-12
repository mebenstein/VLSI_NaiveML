module reg16 (
input enable, clear, clk,
input [15:0] dataIn,
output [15:0] dataOut
);

reg [15:0] regValue;

assign dataOut = regValue;

always @(posedge clk)
if (~clear) begin
  regValue <= 16'b0;
end else if (enable) begin
  regValue <= dataIn;
end

endmodule 