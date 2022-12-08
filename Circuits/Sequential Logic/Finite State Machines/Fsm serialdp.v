module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter idle=0, bit1=1, bit2=2, bit3=3, bit4=4, bit5=5, bit6=6, bit7=7, bit8=8, stopbit=9, received=10, waiting=11, paritybit=12;
    
    reg [3:0] current_state, next_state;
    reg [7:0] data;
    
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
            idle:		next_state 	= in ? idle : bit1;
            bit1:		next_state	= bit2;
            bit2:		next_state	= bit3;
            bit3:		next_state	= bit4;
            bit4:		next_state	= bit5;
            bit5:		next_state	= bit6;
            bit6:		next_state	= bit7;
            bit7:		next_state	= bit8;
            bit8:		next_state	= paritybit;
            paritybit:	next_state	= stopbit;
            stopbit:	next_state	= (1'b0 == in) ? waiting : (parity_w ? received : idle);
            received:	next_state	= in ? idle : bit1;
            waiting:	next_state	= in ? idle : waiting;
            default:
                	next_state	= idle;
        endcase
    end

    assign done = ( (received == current_state)  ) ? 1'b1 : 1'b0;

    // New: Datapath to latch input bits.
    always @ ( posedge clk ) begin
        case ( current_state )
        	bit1:	data <= {in, data[7:1]};
            bit2:	data <= {in, data[7:1]};
            bit3:	data <= {in, data[7:1]};
            bit4:	data <= {in, data[7:1]};
            bit5:	data <= {in, data[7:1]};
            bit6:	data <= {in, data[7:1]};
            bit7:	data <= {in, data[7:1]};
            bit8:	data <= {in, data[7:1]};
            default: data <= data;
        endcase
    end
    
    assign out_byte = data;
    
    wire parity_w, parity_in, reset_in;
    assign parity_in = ( (bit1 == current_state) || 
                        (bit2 == current_state) || 
                        (bit3 == current_state) ||
                        (bit4 == current_state) ||
                        (bit5 == current_state) ||
                        (bit6 == current_state) ||
                        (bit7 == current_state) ||
                        (bit8 == current_state) ||
                        (paritybit == current_state)) && in;
    assign reset_in = (reset || ( current_state == received ) || ( current_state == idle ));
    
    parity check (
        .clk(clk),
        .reset(reset_in),
        .in(parity_in),
        .odd(parity_w)
    );

endmodule
