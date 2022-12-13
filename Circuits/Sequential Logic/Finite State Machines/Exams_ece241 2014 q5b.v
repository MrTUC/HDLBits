module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    localparam A=1'b0, B=1'b1;
    reg	current_state, next_state;
    
    always @ ( * ) begin
        next_state = A;
        case ( current_state )
            A:	begin
                	next_state = x ? B : A;
                	z = x ? 1'b1 : 1'b0;
            	end
            B:	begin
                	next_state = B;
                	z = x ? 1'b0 : 1'b1;
                end
        endcase
    end
    
    always @ ( posedge clk, posedge areset ) begin
        if ( areset )
            current_state <= A;
        else
            current_state <= next_state;
    end
endmodule
