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
    
    localparam 	LEFT=0, RIGHT=1, FALLINGLEFT=2, FALLINGRIGHT=3, DIGGINGLEFT=4, DIGGINGRIGHT=5,SPLAT=6;
    reg [2:0] 	state, next_state;
    
    reg[6:0]	counter;
    wire maxvalue;
    assign maxvalue = ( 6'd19 < counter );

    always @(*) begin
        // State transition logic
        case ( state )
            LEFT:			next_state = ( ~ground ) ? FALLINGLEFT : ( dig ? DIGGINGLEFT : ( bump_left ? RIGHT : state ) );
            RIGHT:			next_state = ( ~ground ) ? FALLINGRIGHT: ( dig ? DIGGINGRIGHT : ( bump_right ? LEFT : state ) );
            FALLINGLEFT:	next_state = ground  ? ( ( maxvalue ) ? SPLAT : LEFT) : state;
            FALLINGRIGHT:	next_state = ground  ? ( ( maxvalue ) ? SPLAT : RIGHT) : state;
            DIGGINGLEFT:	next_state = ( ~ground ) ? FALLINGLEFT : state;
            DIGGINGRIGHT:	next_state = ( ~ground ) ? FALLINGRIGHT : state;
            SPLAT:			next_state = state;
            default:
                			next_state = state;
        endcase
    end
    
    always @ ( posedge clk, posedge areset ) begin
        if ( areset ) begin
            counter <= 6'd0;
        end
        else if ( (FALLINGLEFT == state) || (FALLINGRIGHT == state) )
            counter <= counter + 6'd1;
        else 
            counter <= 6'd0;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if ( areset )
            state <= LEFT;
		else
            state <= next_state;
    end

    always @ (*) begin
        case ( state )
            LEFT:			{walk_left, walk_right, aaah, digging} = 4'b1000;
            RIGHT:			{walk_left, walk_right, aaah, digging} = 4'b0100;
            FALLINGLEFT:	{walk_left, walk_right, aaah, digging} = 4'b0010;
            FALLINGRIGHT:	{walk_left, walk_right, aaah, digging} = 4'b0010;
            DIGGINGLEFT:	{walk_left, walk_right, aaah, digging} = 4'b0001;
            DIGGINGRIGHT:	{walk_left, walk_right, aaah, digging} = 4'b0001;
            SPLAT:			{walk_left, walk_right, aaah, digging} = 4'b0000;
            default:		{walk_left, walk_right, aaah, digging} = 'x;
        endcase
    end

endmodule
