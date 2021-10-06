module top_module 
(
    
    input 			clk,
    input 			reset,    // Active-high synchronous reset to 5'h1
    
    output 	[4:0]	q
); 
    reg		[4:0]	lfsr	=	5'b00001;
    
    always @ ( posedge clk ) begin
        if ( reset )
            lfsr	<=	5'b00001;
        else begin
            lfsr[4]	<=	lfsr[0]^0;
            lfsr[3]	<=	lfsr[4];
            lfsr[2]	<=	lfsr[3]^lfsr[0];
            lfsr[1]	<=	lfsr[2];
            lfsr[0]	<=	lfsr[1];
        end
    end // always

    assign q = lfsr;
    
endmodule
