module computationTileTest;
	reg clock, clear_b, wr;
    reg [3:0] opcode;
	reg [15:0] data_in0, data_in1;
	wire [15:0] data_out;

    computationTile c0(clock, clear_b, opcode, data_in0, data_in1, data_out);

	initial begin
		clock = 1'b0;
		clear_b = 1'b1;
        wr = 1;
		@(posedge clock);
		#1;
		@(posedge clock);
        opcode = 4'h0;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
		#1;
		clear_b = 1'b0;
		#15 
        wr = 1;
		opcode = 4'h1;
        data_in0 = 16'h8ff8; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h8f07;
		#40
        opcode = 4'h8;
        data_in0 = 16'h8ff8; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h8f07;
		#40
        wr = 1;
		opcode = 4'h2;
        data_in0 = 16'h7777; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h8888;
		#40
        opcode = 4'h8;
        data_in0 = 16'h8ff8; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h8f07;
		#40
        wr = 1;
		opcode = 4'h3;
        data_in0 = 16'h1; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h1;
		#40
        #40
        #40
        #40
        #40
        wr = 1;
		opcode = 4'h4;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
		#40
        wr = 1;
        data_in0 = 16'h0fff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
		#40
        wr = 1;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h0fff;
		#40
        wr = 1;
		opcode = 4'h5;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
		#40
        wr = 1;
        data_in0 = 16'h0fff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
		#40
        wr = 1;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h0fff;
		#40
        wr = 1;
		opcode = 4'h6;
        data_in0 = 16'hffff; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
        #40
        wr = 1;
        data_in0 = 16'hfffe; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'hffff;
        #40
        wr = 1;
		opcode = 4'h7;
        data_in0 = 16'h000a; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h000f;
        #40
        wr = 1;
        opcode = 4'hf;
        data_in0 = 16'h0003; //8'hFF, dummy data. should not enter into SSP.
        data_in1 = 16'h0003;
        
	end
	
	always 
	#20 clock = ~clock;

endmodule