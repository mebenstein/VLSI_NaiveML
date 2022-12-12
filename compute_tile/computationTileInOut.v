module computationTileInOut (
input clk, clear,
input [3:0] opcode,
input [15:0] input0,
inout [15:0] input1
);

wire accumulatorEnable, readCell;
wire [15:0] additionOut, multiplicationOut, accumulatorOut, lessThanWire, greaterThanWire, equalToWire, orWire, andWire, notWire, simpleMuxOut, regOut, accumulatorMuxOut;

assign readCell = opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0];
assign input1 = readCell ?  regOut : 16'bzzzzzzzzzzzzzzzz;

assign accumulatorEnable = opcode[3] & opcode[2] & opcode[1] & opcode[0];
assign andWire = input0 & input1;
assign orWire = input0 | input1;
assign notWire = ~input0;

multiplier x0(input0, input1, multiplicationOut);

adder p0(input0, input1, additionOut);

accumulator a0(accumulatorEnable, accumulatorEnable, clk, multiplicationOut, accumulatorOut);

lessThan l0(opcode[3], input0, input1, lessThanWire);
greaterThan g0(opcode[3], input0, input1, greaterThanWire);
equalTo e0(input0, input1, equalToWire);

mux2x16 m1(multiplicationOut, accumulatorOut, opcode[3], accumulatorMuxOut);

mux8x16 m0(notWire, andWire, orWire, additionOut, lessThanWire, greaterThanWire, equalToWire, accumulatorMuxOut, opcode[2:0], simpleMuxOut);

reg16 r0(~readCell, clear, clk, simpleMuxOut, regOut);

endmodule