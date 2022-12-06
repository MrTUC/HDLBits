module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter 	LEFT=3'b000, RIGHT=3'b001, FALLINGLEFT=3'b010, FALLINGRIGHT=3'b011, DIGGINGLEFT=3'b110, DIGGINGRIGHT=3'b111;
    reg [2:0] 	state, next_state;

    always @(*) begin
        // State transition logic
        case ( state )
            LEFT:			if ( ~ground )
                				next_state <= FALLINGLEFT;
            				else if ( dig )
                                next_state <= DIGGINGLEFT;
                			else if ( bump_left )
                				next_state <= RIGHT;
            				else
                        		next_state <= state;
            RIGHT:			if ( ~ground )
                				next_state <= FALLINGRIGHT;
            				else if ( dig )
                                next_state <= DIGGINGRIGHT;
                			else if ( bump_right )
                				next_state <= LEFT;
            				else
                        		next_state <= state;
            FALLINGLEFT:	if (ground)
                				next_state <= LEFT;
            				else
                        		next_state <= state;
            FALLINGRIGHT:	if (ground)
                				next_state <= RIGHT;
            				else
                        		next_state <= state;
            DIGGINGLEFT:	if ( ~ground )
                				next_state <= FALLINGLEFT;
            				else
                        		next_state <= state;
            DIGGINGRIGHT:	if (~ground )
                				next_state <= FALLINGRIGHT;
            				else
                        		next_state <= state;
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
    assign 	walk_left 	= ( LEFT == state )? 1'b1 : 1'b0;
    assign 	walk_right 	= ( RIGHT == state ) ? 1'b1 : 1'b0;
    assign 	aaah 		= ( (state == FALLINGLEFT ) | (state == FALLINGRIGHT ) ) ? 1'b1 : 1'b0;
    assign	digging		= ( ( DIGGINGRIGHT == state ) | ( DIGGINGLEFT == state ) ) ? 1'b1 : 1'b0;
        
    
endmodule
