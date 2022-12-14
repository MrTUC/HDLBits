module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    localparam	A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
    reg[2:0]	current_state, next_state;
         
    always @ ( * ) begin
        next_state = 1'b0;
        case ( current_state ) 
            3'b000: next_state = w ? A : B;
            3'b001: next_state = w ? D : C;
            3'b010: next_state = w ? D : E;
            3'b011: next_state = w ? A : F;
            3'b100: next_state = w ? D : E;
            3'b101: next_state = w ? D : C;
        endcase
    end   
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= 3'b000;
        else
            current_state <= next_state;
    end
    
    always @ ( * ) begin
        z = 1'b0;
        case ( current_state ) 
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b0;
            3'b100: z = 1'b1;
            3'b101: z = 1'b1;
        endcase
    end    
endmodule
