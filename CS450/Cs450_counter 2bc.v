module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    
    localparam SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;
    reg [1:0] current_state, next_state;
    
    always @ ( * ) begin
        next_state = WNT;
        case ( current_state )
            SNT:	next_state = train_taken ? WNT 	: SNT;
            WNT:	next_state = train_taken ? WT	: SNT;
            WT:		next_state = train_taken ? ST	: WNT;
            ST:		next_state = train_taken ? ST	: WT;
        endcase;
    end

    assign state = current_state;
    
    always @ ( posedge clk or posedge areset ) begin
        if ( areset )
            current_state <= WNT;
        else if ( train_valid )
            current_state <= next_state;
        else
            current_state <= current_state;
    end

endmodule
