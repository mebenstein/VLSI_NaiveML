module accumulator (
input enable, clear, clk,
input [15:0] dataIn,
output [15:0] dataOut
);

wire [15:0] regOut, adderOut;

assign dataOut = adderOut;

adder a0(dataIn, regOut, adderOut);

reg16 r0(enable, clear, clk, adderOut, regOut);

endmodule