module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    reg next_state;
    
    always @ ( * ) begin
        next_state = 1'b0;
        case ( y ) 
            3'b000: next_state = w ? 1'b0 : 1'b0;
            3'b001: next_state = w ? 1'b1 : 1'b1;
            3'b010: next_state = w ? 1'b1 : 1'b0;
            3'b011: next_state = w ? 1'b0 : 1'b0;
            3'b100: next_state = w ? 1'b1 : 1'b0;
            3'b101: next_state = w ? 1'b1 : 1'b1;
        endcase
    end
    
    assign Y2 = next_state;

endmodule
