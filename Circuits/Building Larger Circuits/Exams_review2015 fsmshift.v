module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    localparam 	DISABLED = 1'b0, ENABLED = 1'b1;
    reg 		current_state, next_state;
    reg [2:0] counter = 3'b0;
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= ENABLED;
        else
            current_state <= next_state;
    end
    
    always @ ( * ) begin
        next_state = DISABLED;
        case ( current_state )
            DISABLED 	: next_state = reset ? ENABLED : DISABLED;
            ENABLED		: next_state = ( 3'b011 == counter ) ? DISABLED : ENABLED;
        endcase
    end
    
    
    always @ ( posedge clk ) begin
        if ( reset ) 
            counter <= 3'b0;
        else if ( ENABLED == current_state  )
            counter <= counter + 1;
        else
            counter <= 3'b111;
    end
    
    assign shift_ena = ( ENABLED == current_state ) ? 1'b1 : 1'b0;
    
endmodule
