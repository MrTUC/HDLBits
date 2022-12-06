module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter 	LEFT=2'b00, RIGHT=2'b01, FALLINGLEFT=2'b10, FALLINGRIGHT=2'b11;
    reg [1:0] 	state, next_state;

    always @(*) begin
        // State transition logic
        case ( state )
            LEFT:			next_state <= ( ~ground ) ? FALLINGLEFT : ( bump_left ?  RIGHT : state );
            RIGHT:			next_state <= ( ~ground ) ? FALLINGRIGHT : ( bump_right ? LEFT : state);
            FALLINGLEFT:	next_state <= (ground) ? LEFT : state;
            FALLINGRIGHT:	next_state <= (ground) ? RIGHT : state;
            default:
                			next_state <= state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if ( areset ) state <= LEFT;
        else state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
    assign aaah = ( (state == FALLINGLEFT ) | (state == FALLINGRIGHT ) ) ? 1'b1 : 1'b0;

endmodule
