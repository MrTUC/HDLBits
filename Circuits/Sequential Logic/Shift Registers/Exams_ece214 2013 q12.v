module top_module 
(
    input 			clk,
    input 			enable,
    input 			S,
    input 			A, B, C,
    
    output 			Z
); 
    
    reg		[7:0]	Q;
    wire	[2:0]	in	=	{A, B, C};
    
    always	@	( posedge clk ) begin
        if ( enable )
            Q	<=	{Q[6:0], S};
        else
            Q	<=	Q;
    end // always
    
  assign	Z	=	( 3'b000 == in )	?	Q[0]	:
    ( 3'b001 == in )	?	Q[1]	:
    ( 3'b010 == in )	?	Q[2]	:
    ( 3'b011 == in )	?	Q[3]	:
    ( 3'b100 == in )	?	Q[4]	:
    ( 3'b101 == in )	?	Q[5]	:
    ( 3'b110 == in )	?	Q[6]	:
									        Q[7];

endmodule
