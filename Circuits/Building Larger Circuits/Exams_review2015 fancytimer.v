module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    input ack,
    
    output [3:0] count,
    output counting,
    output done );

    localparam	IDLE 		= 4'b0000,
    			ONE			= 4'b0001, 
    			ONEONE		= 4'b0011, 
    			ONEONEZERO	= 4'b0110, 
    			ONEONEONE	= 4'b0111, 
    			SHIFTING	= 4'b1101,
    			COUNTING	= 4'b1000,
    			WAITING		= 4'b1100;
    
    localparam	MAXCOUNT	= 10'd1000;
    
    reg [3:0]	current_state, next_state;
    reg [2:0]	shiftcounter;
    
    reg [9:0]	counter;
    reg [3:0]	delay;
    
    always @ ( * ) begin
        next_state = IDLE;
        case ( current_state )
            IDLE:		next_state = data 	? ONE : IDLE;
            ONE:		next_state = data 	? ONEONE : IDLE;
            ONEONE:		next_state = data 	? ONEONEONE : ONEONEZERO;
            ONEONEONE:	next_state = data	? ONEONEONE : ONEONEZERO;
            ONEONEZERO:	next_state = data 	? SHIFTING : IDLE;
            SHIFTING:	next_state = ( 3'b010 == shiftcounter ) ? COUNTING : SHIFTING;
    		COUNTING:	next_state = done_counting ? WAITING : COUNTING;
    		WAITING:	next_state = ack ? IDLE : WAITING;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            shiftcounter 	<= 3'b000;
		else if ( SHIFTING == current_state  )
            shiftcounter <= shiftcounter + 3'b001;
		else
            shiftcounter <= 3'b111;
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            delay			<= 4'b0000;
        else if ( SHIFTING == current_state  )
            delay <= { delay[2:0], data };
        else if ( MAXCOUNT == counter )
            delay <= delay - 4'd1;
        else
            delay <= delay;
    end
    
    wire done_counting;
    
    always @ ( posedge clk ) begin
        if ( reset || ( MAXCOUNT == counter ) )
            counter <= 10'd1;
        else if ( COUNTING == current_state )
        	counter <= counter + 10'd1;
    end
    
    assign done_counting = ( ( 4'b0000 == delay ) && ( MAXCOUNT == counter ) ) ? 1'b1 : 1'b0;
    assign count = delay;
    
    wire [1:0]	output_w;
    assign counting 	= output_w[1];
    assign done			= output_w[0];    
    
    always @ ( * ) begin
        output_w = 2'b00;
        case ( current_state )
            IDLE:		output_w = 2'b00;
    		ONE:		output_w = 2'b00;
    		ONEONE:		output_w = 2'b00;
    		ONEONEZERO:	output_w = 2'b00;
    		ONEONEONE:	output_w = 2'b00;
    		SHIFTING:	output_w = 2'b00;
    		COUNTING:	output_w = 2'b10;
    		WAITING:	output_w = 2'b01;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
endmodule
