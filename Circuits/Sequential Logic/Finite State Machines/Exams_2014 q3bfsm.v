module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    localparam 	S0 = 3'b000,
    			S1 = 3'b001,
    			S2 = 3'b010,
    			S3 = 3'b011,
    			S4 = 3'b100;
    reg [2:0]	current_state, next_state;
    
    always @ ( * ) begin
        next_state = S0;
        case ( current_state )
            S0:	next_state = x ? S1 : S0;
            S1:	next_state = x ? S4 : S1;
            S2:	next_state = x ? S1 : S2;
            S3:	next_state = x ? S2 : S1;
            S4:	next_state = x ? S4 : S3;
        endcase
    end
    
    always @ ( * ) begin
        z = 1'b0;
        case ( current_state )
            S0:	z = 1'b0;
            S1:	z = 1'b0;
            S2:	z = 1'b0;
            S3:	z = 1'b1;
            S4:	z = 1'b1;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( reset ) 
            current_state <= S0;
        else
            current_state <= next_state;
    end

endmodule
