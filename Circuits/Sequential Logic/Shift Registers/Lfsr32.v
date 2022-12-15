module top_module 
(
    input 			clk,
    input 			reset,    // Active-high synchronous reset to 32'h1
    
    output [31:0]	q
); 
    reg		[31:0]	lfsr;
    
    always @ ( posedge clk ) begin
        if ( reset )
            lfsr	<=	32'h00000001;
        else begin
			lfsr[31]	<=	lfsr[0]^1'b0;
            lfsr[30]	<=	lfsr[31];
            lfsr[29]	<=	lfsr[30];
            lfsr[28]	<=	lfsr[29];
            lfsr[27]	<=	lfsr[28];
            lfsr[26]	<=	lfsr[27];
            lfsr[25]	<=	lfsr[26];
            lfsr[24]	<=	lfsr[25];
            lfsr[23]	<=	lfsr[24];
            lfsr[22]	<=	lfsr[23];            
            lfsr[21]	<=	lfsr[22]^lfsr[0];            
            lfsr[20]	<=	lfsr[21];
            lfsr[19]	<=	lfsr[20];
            lfsr[18]	<=	lfsr[19];
            lfsr[17]	<=	lfsr[18];
            lfsr[16]	<=	lfsr[17];
            lfsr[15]	<=	lfsr[16];
            lfsr[14]	<=	lfsr[15];
            lfsr[13]	<=	lfsr[14];
            lfsr[12]	<=	lfsr[13];            
            lfsr[11]	<=	lfsr[12];
            lfsr[10]	<=	lfsr[11];
            lfsr[9]		<=	lfsr[10];
            lfsr[8]		<=	lfsr[9];
            lfsr[7]		<=	lfsr[8];
            lfsr[6]		<=	lfsr[7];
            lfsr[5]		<=	lfsr[6];
            lfsr[4]		<=	lfsr[5];
            lfsr[3]		<=	lfsr[4];
            lfsr[2]		<=	lfsr[3];
            lfsr[1]		<=	lfsr[2]^lfsr[0];
            lfsr[0]		<=	lfsr[1]^lfsr[0];
        end
    end // always

    assign q = lfsr;
    
endmodule
