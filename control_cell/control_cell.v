/**

 Converts config-cell opcodes to tile opcodes and memory instructions

**/

module CTRL_CELL(clk, rst, code_in, code_out , write , mode_a , mode_b , offset_a , offset_b, addr_a, addr_b, addr_i);
  parameter BLOCK_BITS = 3; // address bits for symmetric axis
  parameter ADDR_BITS = 6;
  parameter WORD_BITS = 16;
  parameter TOC_WIDTH = 4; // Tile OpCode Width
  parameter MODE_BITS = 2;

  parameter BC = (BLOCK_BITS+1)*2; // Block helper variable

  input wire clk, rst;
  input wire [TOC_WIDTH+2*(BC+ADDR_BITS+MODE_BITS):0] code_in;

  output wire [TOC_WIDTH-1:0] code_out;
  output wire [ADDR_BITS-1:0] addr_i;
  output reg [ADDR_BITS-1:0] addr_a, addr_b; // needs to be changed for writing later
  output wire [MODE_BITS-1:0] mode_a, mode_b;
  output wire [BC-1:0] offset_a, offset_b;
  output wire write;

  reg [TOC_WIDTH-1:0] q_opcode[0:2];
  reg [MODE_BITS-1:0] q_mode_a[0:1],q_mode_b[0:1];
  reg [BC-1:0] q_offset_a[0:1],q_offset_b[0:1];
  reg [ADDR_BITS-1:0] q_addr[0:2];
  
  reg [1:0] qc_tile;
  reg qc_viewer;

  wire [1:0] qc_tile_i;
  assign qc_tile_i = (qc_tile == 'b10)? 'b0: qc_tile + 1;; 

  assign code_out = q_opcode[qc_tile];
  assign addr_i = q_addr[qc_tile];

  assign offset_a = q_offset_a[qc_viewer];
  assign offset_b = q_offset_b[qc_viewer];
  assign mode_a = q_mode_a[qc_viewer];
  assign mode_b = q_mode_b[qc_viewer];

  assign write = (code_out == 4'b1000);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      qc_tile <= 'b0;
      qc_viewer <= 'b0;
    end else begin
      q_offset_b[qc_viewer]<= code_in[BC-1:0];
      addr_b <= code_in[BC+ADDR_BITS-1:BC];
      q_mode_b[qc_viewer]  <= code_in[BC+ADDR_BITS+MODE_BITS-1:BC+ADDR_BITS];

      q_offset_a[qc_viewer]  <= code_in[2*BC+ADDR_BITS+MODE_BITS-1:BC+ADDR_BITS+MODE_BITS];
      addr_a <= code_in[2*(BC+ADDR_BITS)+MODE_BITS-1:2*BC+ADDR_BITS+MODE_BITS];
      q_mode_a[qc_viewer]  <= code_in[2*(BC+ADDR_BITS+MODE_BITS)-1:2*(BC+ADDR_BITS)+MODE_BITS];

      q_opcode[qc_tile] <= code_in[TOC_WIDTH+2*(BC+ADDR_BITS+MODE_BITS)-1:2*(BC+ADDR_BITS+MODE_BITS)];
      q_addr[qc_tile] <= code_in[2*(BC+ADDR_BITS)+MODE_BITS-1:2*BC+ADDR_BITS+MODE_BITS];

      qc_tile <= qc_tile_i;
      qc_viewer <= qc_viewer + 1;
    end
  end

endmodule