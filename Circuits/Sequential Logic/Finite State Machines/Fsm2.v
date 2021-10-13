module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case ( state )
            OFF	:	if ( 1'b1 == j )
                next_state = ON;
            ON	:	if ( 1'b1 == k )
                next_state = OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if ( areset )
            state = OFF;
        else
            state = next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = ( OFF == state ) ?	1'b0 :
        1'b1;

endmodule
