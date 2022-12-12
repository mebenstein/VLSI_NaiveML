module regfile16x8 (
input enable, clear, clk, RW,
input [2:0] addr,
input [15:0] dataIn,
output [15:0] dataOut
);

regfile8x8 r0(enable, clear, clk, RW, addr, dataIn[7:0], dataOut[7:0]);
regfile8x8 r1(enable, clear, clk, RW, addr, dataIn[15:8], dataOut[15:8]);

endmodule 