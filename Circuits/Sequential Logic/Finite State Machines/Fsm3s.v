module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    // State transition logic

    // State flip-flops with synchronous reset

    // Output logic
        
    parameter A=0, B=1, C=2, D=3; 
    reg[1:0] state, next_state;

    always @ (*) begin
        // State transition logic
        next_state = state;
        case ( state )
            A	:	if ( 1'b1 == in )
                next_state = B;
            B	:	if ( 1'b0 == in )
                next_state = C;
            C	:	if ( 1'b1 == in )
                next_state = D;
            		else if ( 1'b0 == in )
                next_state = A;
            D	:	if ( 1'b1 == in )
                next_state = B;
            		else if ( 1'b0 == in )
                next_state = C;
        endcase        
    end

    always @ ( posedge clk ) begin
        // State flip-flops with synchronous reset
        if ( reset )
            state = A;
        else
            state = next_state;        
    end

    // Output logic
    // assign out = (state == ...);
    assign out = ( A == state ) ?	1'b0 : 
        ( B == state ) ?	1'b0 : 
        ( C == state ) ?	1'b0 : 
        1'b1;

endmodule
