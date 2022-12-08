module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    localparam 	IDLE=0,
    			BIT1=1,
    			BIT2=2,
    			BIT3=3,
    			BIT4=4,
    			BIT5=5,
    			BIT6=6,
    			DISCARD=7,
    			FRAME=8,
    			ERROR=9;
    
    reg [3:0]	current_state, next_state;
    
    always @ ( posedge clk ) begin
        if (reset )
            current_state = IDLE;
        else
            current_state = next_state;
    end
    
    always @ (*) begin
        case ( current_state )
            IDLE:		next_state = in ? BIT1 : IDLE;
            BIT1:		next_state = in ? BIT2 : IDLE;
            BIT2:		next_state = in ? BIT3 : IDLE;
            BIT3:		next_state = in ? BIT4 : IDLE;
            BIT4:		next_state = in ? BIT5 : IDLE;
            BIT5:		next_state = in ? BIT6 : DISCARD;
            BIT6:		next_state = in ? ERROR : FRAME;
            DISCARD:	next_state = in ? BIT1 : IDLE;
            FRAME:		next_state = in ? BIT1 : IDLE;
            ERROR:		next_state = in ? ERROR : IDLE;
            default:	next_state = IDLE;
        endcase
    end
    
    assign disc = ( DISCARD == current_state ) ? 1'b1 : 1'b0;
    assign err	= ( ERROR == current_state ) ? 1'b1 : 1'b0;
    assign flag = ( FRAME == current_state ) ? 1'b1 : 1'b0;
    
endmodule
