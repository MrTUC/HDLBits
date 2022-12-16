module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    input done_counting,
	input ack,
    
    output shift_ena,
    output counting,
    output done
);
    
    localparam	IDLE 		= 4'b0000,
    			ONE			= 4'b0001, 
    			ONEONE		= 4'b0011, 
    			ONEONEZERO	= 4'b0110, 
    			ONEONEONE	= 4'b0111, 
    			SHIFTING	= 4'b1101,
    			COUNTING	= 4'b1000,
    			WAITING		= 4'b1100;
    
    reg [3:0]	current_state, next_state;
    reg [2:0]	counter;
    
    always @ ( * ) begin
        next_state = IDLE;
        case ( current_state )
            IDLE:		next_state = data 	? ONE : IDLE;
            ONE:		next_state = data 	? ONEONE : IDLE;
            ONEONE:		next_state = data 	? ONEONEONE : ONEONEZERO;
            ONEONEONE:	next_state = data	? ONEONEONE : ONEONEZERO;
            ONEONEZERO:	next_state = data 	? SHIFTING : IDLE;
            SHIFTING:	next_state = ( 3'b010 == counter ) ? COUNTING : SHIFTING;
    		COUNTING:	next_state = done_counting ? WAITING : COUNTING;
    		WAITING:	next_state = ack ? IDLE : WAITING;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            counter <= 3'b000;
        else if ( SHIFTING == current_state  )
            counter <= counter + 3'b001;
        else
            counter <= 3'b111;
    end            
    
    wire [2:0]	output_w;
    assign shift_ena	= output_w[2];
    assign counting 	= output_w[1];
    assign done			= output_w[0];    
    
    always @ ( * ) begin
        output_w = 2'b00;
        case ( current_state )
            IDLE:		output_w = 3'b000;
    		ONE:		output_w = 3'b000;
    		ONEONE:		output_w = 3'b000;
    		ONEONEZERO:	output_w = 3'b000;
    		ONEONEONE:	output_w = 3'b000;
    		SHIFTING:	output_w = 3'b100;
    		COUNTING:	output_w = 3'b010;
    		WAITING:	output_w = 3'b001;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
endmodule
