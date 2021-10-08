module top_module
(
    input			clk,
    input			reset,
    
    output	[9:0]	q
);
    
    always @ ( posedge clk ) begin
        if ( reset | ( 10'd999 == q ) )
            q	<=	0;
        else
            q	<=	q + 1; 
    end // always @

endmodule
