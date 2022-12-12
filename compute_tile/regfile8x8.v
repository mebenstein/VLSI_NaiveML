module regfile8x8 (
input enable, clear, clk, RW,
input [2:0] addr,
input [7:0] dataIn,
output [7:0] dataOut
);

wire [7:0] regEnable;
wire [7:0] decoderOut;
wire [7:0] regOut [7:0];
wire [7:0] muxOut;

assign dataOut = RW ? 8'bzzzzzzzz : muxOut;

assign regEnable[0] = decoderOut[0] & RW;
assign regEnable[1] = decoderOut[1] & RW;
assign regEnable[2] = decoderOut[2] & RW;
assign regEnable[3] = decoderOut[3] & RW;
assign regEnable[4] = decoderOut[4] & RW;
assign regEnable[5] = decoderOut[5] & RW;
assign regEnable[6] = decoderOut[6] & RW;
assign regEnable[7] = decoderOut[7] & RW;

decoder3x8 d0(addr, decoderOut);
reg8 r0(regEnable[0], clear, clk, dataIn, regOut[0]);
reg8 r1(regEnable[1], clear, clk, dataIn, regOut[1]);
reg8 r2(regEnable[2], clear, clk, dataIn, regOut[2]);
reg8 r3(regEnable[3], clear, clk, dataIn, regOut[3]);
reg8 r4(regEnable[4], clear, clk, dataIn, regOut[4]);
reg8 r5(regEnable[5], clear, clk, dataIn, regOut[5]);
reg8 r6(regEnable[6], clear, clk, dataIn, regOut[6]);
reg8 r7(regEnable[7], clear, clk, dataIn, regOut[7]);

mux8x8 m0(regOut[0], regOut[1], regOut[2], regOut[3], regOut[4], regOut[5], regOut[6], regOut[7], addr, muxOut);

endmodule 