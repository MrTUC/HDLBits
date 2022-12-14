module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    localparam A=6'b000001, B=6'b000010, C=6'b000100, D=6'b001000, E=6'b010000, F=6'b100000;
    reg [5:0] next_state;
    wire [5:0] newA, newB, newC, newD, newE, newF, state_in;
    
    assign	newA 	= y & A;
    assign	newB	= y & B;
    assign	newC	= y & C;
    assign	newD	= y & D;
    assign	newE	= y & E;
    assign	newF	= y & F;
    assign	state_in	= newA | newB | newC | newD | newE | newF;
    
    assign Y2 = next_state[1];
    assign Y4 = next_state[3];
    
    always @ ( * ) begin
        next_state = 6'b000001;
        case ( state_in )
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
        endcase
    end
       
endmodule
