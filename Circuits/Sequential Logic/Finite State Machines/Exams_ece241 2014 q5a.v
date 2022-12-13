module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    localparam ZERO=0, INVERTZERO=1, INVERTONE=2;
    
    reg [1:0] current_state, next_state;
    
    always @ ( posedge clk, posedge areset ) begin
        if ( areset )
            current_state <= ZERO;
        else
            current_state <= next_state;
    end
    
    always @ (*) begin
        next_state = ZERO;
        case ( current_state )
            ZERO:		next_state = x ? INVERTZERO : ZERO;
            INVERTZERO:	next_state = x ? INVERTONE : INVERTZERO;
            INVERTONE:	next_state = x ? INVERTONE : INVERTZERO;
        endcase
    end
    
    always @ (*) begin
        z = 1'b0;
        case ( current_state )
            ZERO:			z = 1'b0;
            INVERTZERO:		z = 1'b1;
            INVERTONE:		z = 1'b0;
        endcase
    end

endmodule
