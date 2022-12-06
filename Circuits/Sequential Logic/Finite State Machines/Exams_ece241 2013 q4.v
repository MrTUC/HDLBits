module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [2:0]	current_state, next_state;
    
    always @ (*) begin
        next_state = current_state;
        case ( current_state )
            0	:	if ( 3'b000 == s )
                		next_state = 0;
            		else if ( 3'b001 == s )
                        next_state = 2;
            		else if ( 3'b011 == s )
                        next_state = 3;
            		else if ( 3'b111 == s )
                        next_state = 4;
            1	:	if ( 3'b001 == s )
                        next_state = 2;
            		else if ( 3'b000 == s )
                        next_state = 0;
            2	:	if ( 3'b011 == s )
                        next_state = 3;
            		else if ( 3'b000 == s )
                        next_state = 0;
            3	:	if ( 3'b111 == s )
                        next_state = 4;
            		else if ( 3'b001 == s )
                        next_state = 6;
            4	:	if ( 3'b011 == s )
                        next_state = 5;
            5	:	if ( 3'b001 == s )
                        next_state = 6;
            		else if ( 3'b111 == s )
                        next_state = 4;
            6	:	if ( 3'b000 == s )
                        next_state = 0;
            		else if ( 3'b011 == s )
                        next_state = 3;
            default:	next_state = 0;
        endcase        
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state = 0;
        else
            current_state = next_state;
    end
    
    assign fr1	= ( 0 == current_state ) ? 1'b1 : ( 1 == current_state ) ? 1'b1 : ( 2 == current_state ) ? 1'b1 : ( 3 == current_state ) ? 1'b1 : 
        ( 5 == current_state ) ? 1'b1 : ( 6 == current_state ) ? 1'b1 : 1'b0;
    assign fr2	= ( 0 == current_state ) ? 1'b1 : ( 1 == current_state ) ? 1'b1 : ( 2 == current_state ) ? 1'b1 : ( 6 == current_state ) ? 1'b1 : 1'b0;
    assign fr3	= ( 0 == current_state ) ? 1'b1 : ( 1 == current_state ) ? 1'b1 : 1'b0;
    assign dfr	= ( 0 == current_state ) ? 1'b1 : ( 5 == current_state ) ? 1'b1 : ( 6 == current_state )  ? 1'b1 : 1'b0;    
endmodule
