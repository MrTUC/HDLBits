module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    localparam 	IDLE=0, ONE=1, ZERO=2;
    reg	[1:0]	current_state, next_state;
    
    always @ ( posedge clk, negedge aresetn ) begin
        if ( !aresetn )
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    always @ (*) begin
        next_state = IDLE;
        case ( current_state )
            IDLE:	next_state = x ? ONE : IDLE;
            ONE:	next_state = x ? ONE : ZERO;
            ZERO:	next_state = x ? ONE : IDLE;
        endcase
    end
    
    always @ (*) begin
        z = 1'b0;
        case ( current_state )
            IDLE:	z = 1'b0;
            ONE:	z = 1'b0;
            ZERO:	z = (next_state == ONE) ? 1'b1 : 1'b0;
        endcase
    end
    
endmodule
