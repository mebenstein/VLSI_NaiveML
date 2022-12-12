`include "ctrl_memory.v"
`include "memory_viewer.v"

module test;
  reg clk = 1;

  wire [1023:0] value_a, value_b, wire_a, wire_b;
  reg [5:0] addr_a, addr_b;
  reg signed [3:0] offset_x_a, offset_y_a, offset_x_b, offset_y_b;
  reg [1:0] mode_a, mode_b;
  reg rw = 1;

  initial begin
    // test default reading

    addr_a = 'b0;
    addr_b = 'b1;
    offset_x_a = 'b0;
    offset_y_a = 'b0;
    offset_x_b = 'b0;
    offset_y_b = 'b0;
    mode_a = 'b0;
    mode_b = 'b0;
    clk = 1;

    # 10 
    clk = 0;
    # 10

    clk = 1;

    # 10 
    clk = 0;
    # 10
    // test offset in block and word mode
    offset_x_a = 'b11;
    offset_y_a = 'b01;
    offset_x_b = 'b111;
    offset_y_b = 'b110;
    mode_b = 'b01;
    clk = 1;

    # 10 
    clk = 0;
    # 10
    // test negaitve offsets
    offset_x_a = 'b1001;
    offset_y_a = 'b1001;
    offset_x_b = 'b1;
    offset_y_b = 'b1;
    clk = 1;

    # 10 
    clk = 0;
    # 10

    offset_x_a = 'b1011;
    offset_y_a = 'b0011;
    offset_x_b = 'b1;
    offset_y_b = 'b11;
    clk = 1;

    # 10 
    clk = 0;
    # 10
    
    # 100 $stop;
  end



  CTRL_MEMORY memory (clk, rw, addr_a, wire_a, addr_b, wire_b);
  MEMORY_VIEWER view_a (clk, mode_a, wire_a, value_a, offset_x_a, offset_y_a);
  MEMORY_VIEWER view_b (clk, mode_b, wire_b, value_b, offset_x_b, offset_y_b);

  initial begin
    $dumpfile("memory.vcd");
    $dumpvars(0,value_a);
    $dumpvars(0,value_b);
    $dumpvars(0,wire_a);
    $dumpvars(0,wire_b);
    $monitor("At time %t, value = %h (%0d)",
              $time, clk, clk);
  end
endmodule // test
