module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter idle=0, bit1=1, bit2=2, bit3=3, bit4=4, bit5=5, bit6=6, bit7=7, bit8=8, stopbit=9, received=10, waiting=11;
    
    reg [3:0] current_state, next_state;
    
    always @ ( posedge clk ) begin
        if ( reset ) begin
            current_state <= idle;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always @ * begin
        case ( current_state )
            idle:		next_state 	= ( 1'b0 == in ) ? bit1 : idle;
            bit1:		next_state	= bit2;
            bit2:		next_state	= bit3;
            bit3:		next_state	= bit4;
            bit4:		next_state	= bit5;
            bit5:		next_state	= bit6;
            bit6:		next_state	= bit7;
            bit7:		next_state	= bit8;
            bit8:		next_state	= stopbit;
            stopbit:	next_state	= ( 1'b1 == in ) ? received : waiting;
            waiting:	next_state	= ( 1'b0 == in ) ? waiting : idle;
            received:	next_state	= ( 1'b0 == in ) ? bit1 : idle;
            default:
                	next_state	= idle;
        endcase
    end

    assign done = ( received == current_state ) ? 1'b1 : 1'b0;

endmodule
