module FIFO4(
    input enable, outputFinished, reset, clk,
    input [7:0] dataIn,
    output fifoFull, fifoEmpty,
    output [7:0] dataOut
);

reg full, empty;
reg [7:0] fifoValue;
reg [4:0] readPtr, writePtr;
wire [3:0] writeSignal;
wire [7:0] regOut [3:0];

assign fifoFull = full;
assign fifoEmpty = empty;
assign dataOut = fifoValue;

assign  writeSignal[0] = enable & writePtr [0];
assign  writeSignal[1] = enable & writePtr [1];
assign  writeSignal[2] = enable & writePtr [2];
assign  writeSignal[3] = enable & writePtr [3];

reg8 r0(writeSignal[0], reset, clk, dataIn, regOut[0]);
reg8 r1(writeSignal[1], reset, clk, dataIn, regOut[1]);
reg8 r2(writeSignal[2], reset, clk, dataIn, regOut[2]);
reg8 r3(writeSignal[3], reset, clk, dataIn, regOut[3]);

always @*
begin
    if(readPtr[3:0] == 1) begin
        fifoValue <= regOut[0];
    end else if(readPtr[3:0] == 2) begin
        fifoValue <= regOut[1];
    end else if(readPtr[3:0] == 4) begin
        fifoValue <= regOut[2];
    end else if(readPtr == 8) begin
        fifoValue <= regOut[3];
    end
end

always @(posedge clk)
begin
    if(~reset) begin
        readPtr <= 5'b00001;
        writePtr <= 5'b00001;
    end else begin
    if(enable && fifoFull == 0) begin
        if(writePtr[3:0] != 8) begin
            writePtr[3:0] <= writePtr[3:0] << 1;
        end else begin
            writePtr[3:0] <= 4'b0001;
            writePtr[4] <= ~writePtr[4];
        end
    end
    if(outputFinished && fifoEmpty == 0) begin
        if(readPtr[3:0] != 8) begin
            readPtr[3:0] <= readPtr[3:0] << 1;
        end else begin
            readPtr[3:0] <= 4'b0001;
            readPtr[4] <= ~readPtr[4];
        end
    end
    end  
end

always @(writePtr or readPtr)
begin
    if(~reset)begin 
        full <= 0;
        empty <= 1;
    end else if({~writePtr[4], writePtr[3:0]} == readPtr) begin
        full <= 1;
        empty <= 0;
    end else if(writePtr == readPtr)begin
        full <= 0;
        empty <= 1;
    end else begin
        full <= 0;
        empty <= 0;
    end
end

endmodule