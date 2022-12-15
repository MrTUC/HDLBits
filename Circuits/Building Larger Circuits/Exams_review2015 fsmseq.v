module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    localparam	IDLE=4'b0000, 
    			ONE=4'b0001, 
    			ONEONE=4'b0011, 
    			ONEONEZERO=4'b0110, 
    			ONEONEONE=4'b0111, 
    			FOUND=4'b1101;
    
    reg [3:0]	current_state, next_state;
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= IDLE;
        else
            current_state <= next_state;            
    end
    
    always @ ( * ) begin
        next_state = IDLE;
        case ( current_state )
            IDLE:		next_state = data 	? ONE : IDLE;
            ONE:		next_state = data 	? ONEONE : IDLE;
            ONEONE:		next_state = data 	? ONEONEONE : ONEONEZERO;
            ONEONEONE:	next_state = data	? ONEONEONE : ONEONEZERO;
            ONEONEZERO:	next_state = data 	? FOUND : IDLE;
            FOUND:		next_state = FOUND;
        endcase
    end
                
    always @ ( * ) begin
        start_shifting = 1'b0;
        case ( current_state )
            IDLE:		start_shifting = 1'b0;
            ONE:		start_shifting = 1'b0;
            ONEONE:		start_shifting = 1'b0;
            ONEONEZERO:	start_shifting = 1'b0;
            FOUND:		start_shifting = 1'b1;
        endcase
    end                

endmodule
