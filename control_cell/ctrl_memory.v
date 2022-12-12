/*
This module represents a memory that stores data in memory blocks that correspond to the compute array size.
The default values are for a 8x8 compute array, with 16-bit words and support for 36 blocks. Each block corresponds to ~1 compute graph operation.
This module supports parallel accesses from two data lines and write accesses from one line.
*/

module CTRL_MEMORY(clk, write, addr_a, data_a, addr_b, data_b, addr_i, data_i);
  parameter ADDR_BITS = 6; // address bits for blocks
  parameter BLOCK_WIDTH = 8; // address bits for symmetric axis
  parameter WORD_BITS = 16;

  reg [WORD_BITS*BLOCK_WIDTH**2-1:0] mem [2**ADDR_BITS-1:0];

  input wire clk, write;
  input [ADDR_BITS-1:0] addr_a, addr_b, addr_i;
  input [WORD_BITS*BLOCK_WIDTH**2-1:0] data_i;
  
  output reg [WORD_BITS*BLOCK_WIDTH**2-1:0] data_a, data_b;


  always @(posedge clk) begin
    // read
    data_a <= mem[addr_a];
    data_b <= mem[addr_b];

    if(write) mem[addr_i] <= data_i;
  end

  initial begin 
      $display("Loading rom.");
      $readmemh("projectdata/images/weights.data", mem);
  end

endmodule