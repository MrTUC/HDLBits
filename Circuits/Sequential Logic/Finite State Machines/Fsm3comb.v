module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @ (*) begin
        next_state = state;
        case ( state )
            A	:	if ( 1'b1 == in )
                		next_state = B;
            B	:	if ( 1'b0 == in )
                		next_state = C;
            C	:	if ( 1'b0 == in )
                		next_state = A;
            		else if ( 1'b1 == in )
                		next_state = D;
            D	:	if ( 1'b0 == in )
                		next_state = C;
            		else if ( 1'b1 == in )
                		next_state = B;
        endcase // state
    end // always (*)

    // Output logic:  out = f(state) for a Moore state machine
    assign out = 	
        ( A == state ) ? 1'b0 :
        ( B == state ) ? 1'b0 :
        ( C == state ) ? 1'b0 :
        1'b1;

endmodule
