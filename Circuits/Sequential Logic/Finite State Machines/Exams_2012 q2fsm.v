module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);

    localparam	A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
    reg[2:0]	current_state, next_state;
         
    always @ ( * ) begin
        next_state = 1'b0;
        case ( current_state ) 
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
        endcase
    end   
    
    always @ ( posedge clk ) begin
        if ( reset )
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    always @ ( * ) begin
        z = 1'b0;
        case ( current_state ) 
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
        endcase
    end        
endmodule
