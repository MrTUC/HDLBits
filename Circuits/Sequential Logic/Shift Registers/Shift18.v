module top_module 
    (
    	input 			clk,
    	input 			load,
    	input 			ena,
    	input	[1:0]	amount,
    	input	[63:0]	data,
        
    	output	reg	[63:0]	q
    );	//	ports
    
    localparam			BYTE 			= 8, 
    					BIT 			= 1;
    
    localparam			LEFTONEBIT 		= 2'b00, 
    					LEFTONEBYTE 	= 2'b01, 
    					RIGHTONEBIT 	= 2'b10, 
    					RIGHTONEBYTE	= 2'b11;
    
    always @ ( posedge clk ) begin
        if ( load )
            q	<=	data;
        else if ( ena ) begin
            case ( amount )
                LEFTONEBIT		:	q	<=	q << BIT;
                LEFTONEBYTE		:	q	<=	q << BYTE;
                RIGHTONEBIT		:	q	<=	{ q[63], q[63:BIT] };
                RIGHTONEBYTE	:	q	<=	{ {8{q[63]}}, q[63:BYTE] };                
            endcase
        end
    end

endmodule
