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
            LEFT:			next_state <= ( ~ground ) ? FALLINGLEFT : ( dig ? DIGGINGLEFT : ( bump_left ? RIGHT : state ) );
            RIGHT:			next_state <= ( ~ground ) ? FALLINGRIGHT: ( dig ? DIGGINGRIGHT : ( bump_right ? LEFT : state ) );
            FALLINGLEFT:	next_state <= ( ground ) ? LEFT : state;
            FALLINGRIGHT:	next_state <= ( ground ) ? RIGHT : state;
            DIGGINGLEFT:	next_state <= ( ~ground ) ? FALLINGLEFT : state;
            DIGGINGRIGHT:	next_state <= ( ~ground ) ? FALLINGRIGHT : state;
            default:
                			next_state <= state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if ( areset ) state <= LEFT;
        else state <= next_state;
    end

    always @ (*) begin
        case ( state )
            LEFT:			{walk_left, walk_right, aaah, digging} = 4'b1000;
            RIGHT:			{walk_left, walk_right, aaah, digging} = 4'b0100;
            FALLINGLEFT:	{walk_left, walk_right, aaah, digging} = 4'b0010;
            FALLINGRIGHT:	{walk_left, walk_right, aaah, digging} = 4'b0010;
            DIGGINGLEFT:	{walk_left, walk_right, aaah, digging} = 4'b0001;
            DIGGINGRIGHT:	{walk_left, walk_right, aaah, digging} = 4'b0001;
            default:		{walk_left, walk_right, aaah, digging} = 'x;
        endcase
    end
    
endmodule
