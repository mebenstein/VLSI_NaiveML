module coreflow();
    parameter BLOCK_BITS = 3; // address bits for symmetric axis
    parameter ADDR_BITS = 6;
    parameter WORD_BITS = 16;

    // not essential
    parameter TOC_WIDTH = 4;
    parameter MODE_BITS = 2;
    parameter BC = (BLOCK_BITS+1)*2;

    parameter BLOCK_WIDTH = 2**BLOCK_BITS;

    reg clk, mem_clk, rst;

    wire [WORD_BITS*BLOCK_WIDTH**2-1:0] value_a, value_b, wire_a, wire_b, wire_out;
    wire [ADDR_BITS-1:0] addr_a, addr_b, addr_i;
    wire [BC-1:0] offset_a, offset_b;
    wire [1:0] mode_a, mode_b;
    wire write;

    wire [TOC_WIDTH+2*(BC+ADDR_BITS+MODE_BITS):0] ctrl_opcode;
    wire [TOC_WIDTH-1:0] tile_opcode;

    CTRL_MEMORY #(ADDR_BITS, BLOCK_WIDTH, WORD_BITS) memory (clk, write, addr_a, wire_a, addr_b, wire_b, addr_i, wire_out);
    MEMORY_VIEWER #(BLOCK_BITS, WORD_BITS) view_a (clk, mode_a, wire_a, value_a, offset_a[BC-1:BLOCK_BITS+1], offset_a[BLOCK_BITS:0]);
    MEMORY_VIEWER #(BLOCK_BITS, WORD_BITS) view_b (clk, mode_b, wire_b, value_b, offset_b[BC-1:BLOCK_BITS+1], offset_b[BLOCK_BITS:0]);

    PROG_LOADER #(BLOCK_BITS, ADDR_BITS, WORD_BITS) loader (clk, rst, ctrl_opcode);
    CTRL_CELL #(BLOCK_BITS, ADDR_BITS, WORD_BITS) ctrl_cell (clk, rst, ctrl_opcode, tile_opcode, write, mode_a, mode_b, offset_a, offset_b, addr_a, addr_b, addr_i);

    generate 
        genvar i;
        for(i = 0; i < BLOCK_WIDTH**2; i = i+1) begin: ctl 
            computationTile tile_i(clk, rst, tile_opcode, 
                value_a[WORD_BITS*(i+1)-1:WORD_BITS*i],
                value_b[WORD_BITS*(i+1)-1:WORD_BITS*i],
                wire_out[WORD_BITS*(i+1)-1:WORD_BITS*i]
            );
        end 
    endgenerate
   

    always #10 clk=~clk;

    initial begin
    // test default reading
        rst = 1;
        clk = 0;
        mem_clk = 0;
        #15
        rst = 0;

        #27300 $stop;
    end
endmodule