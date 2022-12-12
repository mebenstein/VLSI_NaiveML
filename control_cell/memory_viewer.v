/*
This module provides a view on a 2d memory block. The view can be modified via an offset in the x and y direction.
It supports multiple viewing modes:
block: views the whole block, with the data offsets from the top-left and the remaining values filled with 0
word: a single word at the offset location is broadcast to the whole output array
// probably coming
row: broadcast a single row along the y-axis
col: broadcast a single col along the x-axis
default setup:
8x8 compute array, with 16-bit word
*/

module MEMORY_VIEWER(clk, mode, data_in, data_out, offset_x, offset_y);
  parameter BLOCK_BITS = 3; // address bits for symmetric axis
  parameter WORD_BITS = 16;

  parameter BLOCK_WIDTH = 2**BLOCK_BITS;
  parameter BUS_N = WORD_BITS*BLOCK_WIDTH**2-1;

  input wire clk;
  input wire [1:0] mode;
  input wire [BUS_N:0] data_in;
  input wire [BLOCK_BITS:0] offset_x, offset_y; // if we can dynamically interpret them as signed/unsigned we can save one bit, 
                                                         // since for word view we'll never need negatives and for block view we only need a small range of values

  output wire [BUS_N:0] data_out;

  wire [WORD_BITS-1:0] in_2d [0:BLOCK_WIDTH-1][0:BLOCK_WIDTH-1];
  reg [WORD_BITS-1:0] out_2d [0:BLOCK_WIDTH-1][0:BLOCK_WIDTH-1];

  // flat -> 2d, 2d -> flat
  genvar i,j;
  generate
    for(j = 0; j < BLOCK_WIDTH; j = j+1) begin:b1
    for(i = 0; i < BLOCK_WIDTH; i = i+1) begin:b2
        assign in_2d[j][i] = data_in[BUS_N-(BLOCK_WIDTH*j+i)*WORD_BITS:BUS_N-(BLOCK_WIDTH*j+i+1)*WORD_BITS+1];
        assign data_out[BUS_N-(BLOCK_WIDTH*j+i)*WORD_BITS:BUS_N-(BLOCK_WIDTH*j+i+1)*WORD_BITS+1] = out_2d[j][i];
    end
  end
  endgenerate

  wire [BLOCK_BITS-1:0] ox, oy;
  wire sx, sy;

  assign ox = offset_x[BLOCK_BITS-1:0];
  assign oy = offset_y[BLOCK_BITS-1:0];

  assign sx = offset_x[BLOCK_BITS];
  assign sy = offset_y[BLOCK_BITS];

  integer x, y;
  always @(posedge clk)
    if(mode == 'b00) begin 
        // read matrix
        for(y = 0; y < BLOCK_WIDTH; y = y+1)
            for(x = 0; x < BLOCK_WIDTH; x = x+1) 
                if(sx)
                    if(sy)
                        out_2d[y][x] = (x < (BLOCK_WIDTH - ox) && y < (BLOCK_WIDTH - oy)) ? in_2d[y+oy][x+ox] : 'b0;
                    else 
                        out_2d[y][x] = (x < (BLOCK_WIDTH - ox) && y >= oy) ? in_2d[y-oy][x+ox] : 'b0;
                else 
                    if(sy)
                        out_2d[y][x] = (x >= ox && y < (BLOCK_WIDTH - oy)) ? in_2d[y+oy][x-ox] : 'b0;
                    else 
                        out_2d[y][x] = (x >= ox && y >= oy) ? in_2d[y-oy][x-ox] : 'b0;
    end else if (mode == 'b01) begin
        // read single value
        for(x = 0; x < BLOCK_WIDTH; x = x+1)
            for(y = 0; y < BLOCK_WIDTH; y = y+1)
                out_2d[x][y] <= in_2d[offset_y][offset_x];
    end else if (mode == 'b10) begin
        // read rows

    end else if (mode == 'b11) begin
        // read columns

    end 

endmodule 