module computationTile (
input clk, clear,
input [3:0] opcode,
input [15:0] input0, input1_wire,
output [15:0] cellOut
);

wire accumulatorEnable, readCell;
wire [15:0] additionOut, multiplicationOut, accumulatorOut, lessThanWire, greaterThanWire, equalToWire, orWire, andWire, notWire, simpleMuxOut, accumulatorMuxOut, regOut, input1;

reg cacheOperand, prepareCache;

assign readCell = opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0];
assign cellOut = readCell ? regOut : simpleMuxOut;
assign accumulatorEnable = (opcode[3] & opcode[2] & opcode[1] & opcode[0]) & ~clear;
assign andWire = input0 & input1;
assign orWire = input0 | input1;
assign notWire = ~input0;
assign input1 = cacheOperand ? regOut : input1_wire;

multiplier x0(input0, input1, multiplicationOut);

adder p0(input0, input1, additionOut);

accumulator a0(accumulatorEnable, accumulatorEnable, clk, multiplicationOut, accumulatorOut);

lessThan l0(opcode[3], input0, input1, lessThanWire);
greaterThan g0(opcode[3], input0, input1, greaterThanWire);
equalTo e0(input0, input1, equalToWire);

mux2x16 m1(multiplicationOut, accumulatorOut, opcode[3], accumulatorMuxOut);

mux8x16 m0(notWire, andWire, orWire, additionOut, lessThanWire, greaterThanWire, equalToWire, accumulatorMuxOut, opcode[2:0], simpleMuxOut);

reg16 r0(~readCell, ~clear, clk, simpleMuxOut, regOut);

always@(negedge clk)begin
    if(clear == 1)begin
        cacheOperand <= 0;
        prepareCache <= 0;
    end else if(opcode == 8)begin
        cacheOperand <= 0;
        prepareCache <= 0;
    end else if(opcode != 8 && opcode != 15 && prepareCache == 1) begin
        prepareCache <= 1;
        cacheOperand <= 1;
    end else if(opcode != 8)begin
        prepareCache <= 1;
        cacheOperand <= 0;
    end
end


endmodule