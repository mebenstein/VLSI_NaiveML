
/*

Reads one config-cell opcodes from a file with every cycle 

*/

module PROG_LOADER(clk, rst, code_out);
    parameter BLOCK_BITS = 3; // address bits for symmetric axis
    parameter ADDR_BITS = 6;
    parameter WORD_BITS = 16;
    parameter TOC_WIDTH = 4;
    parameter MODE_BITS = 2;
    parameter PC_BITS = 12; 

    parameter BC = (BLOCK_BITS+1)*2; 

    input wire clk, rst;
    output reg [TOC_WIDTH+2*(BC+ADDR_BITS+MODE_BITS):0] code_out;

    reg [TOC_WIDTH+2*(BC+ADDR_BITS+MODE_BITS):0] instructions [2**PC_BITS:0];
    reg [PC_BITS:0] PC;

    always @(posedge clk or posedge rst) 
        if(rst) begin
            PC = 0;
        end else begin
            if(PC + 1 == 'b0) 
                code_out = 'b0;
            else begin
                code_out = instructions[PC];
                PC = PC + 1;
            end
        end 

    initial begin 
        $display("Loading program.");
        $readmemh("projectdata/images/program.data", instructions);
    end

endmodule 