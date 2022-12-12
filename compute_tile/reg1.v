module reg1 (
input enable, clear, clk, dataIn,
output dataOut
);

reg regValue;

assign dataOut = regValue;

always @(posedge clk)
if (~clear) begin
  regValue <= 1'b0;
end else if (enable) begin
  regValue <= dataIn;
end

endmodule 