module top_module
(
    input 			clk,
    input 			shift_ena,
    input 			count_ena,
    input 			data,
    
    output	[3:0]	q
);
    reg		[3:0]	internal;
    
    always @ ( posedge clk ) begin
        if ( shift_ena )
            internal	<=	{internal[2:0], data};
        else if ( count_ena )
            internal	<=	internal - 1;
    end // always
    
    assign	q	=	internal;

endmodule
