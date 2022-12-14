module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    localparam A=2'b00, B=2'b01, C=2'b10, D=2'b11;
    reg [1:0]	current_state, next_state;
    
    wire [3:1] rone, rtwo, rthree;
    assign rone = 	r & 3'bxx1;
    assign rtwo = 	r & 3'bx10;
    assign rthree = r & 3'b100;
    
    always @ ( * ) begin
        next_state = A;
        case ( current_state )
            A:	next_state = rone 	? B : ( rtwo ? C : ( rthree ? D : A));
            B:	next_state = rone 	? B : A;
            C:	next_state = rtwo 	? C : A;
            D:	next_state = rthree ? D : A;
        endcase
    end
    
	always @ ( * ) begin
        g = 3'b000;
        case ( current_state )
            A:	g = 3'b000;
            B:	g = 3'b001;
            C:	g = 3'b010;
            D:	g = 3'b100;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( !resetn )
            current_state <= A;
        else
            current_state <= next_state;
    end
endmodule
