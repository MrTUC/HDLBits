module top_module 
(
    input 	[3:0] 	SW,
    input 	[3:0] 	KEY,
    
    output 	[3:0] 	LEDR
); //
    
    wire	[3:0]	R;
    wire	[3:0]	Q;
    wire	[3:0]	w;
    wire			E;
    wire			L;
    wire			clock;
    
    
    assign			R		=	SW;
    assign			clock	=	KEY[0];
    assign			E		=	KEY[1];
    assign			L		=	KEY[2];
    assign			w		=	KEY[3];    
    
    muxdff	stage3	( .clk(clock), 	.w(w), 		.R(R[3]), .E(E), .L(L), .Q(Q[3]) );
    muxdff	stage2	( .clk(clock), 	.w(Q[3]), 	.R(R[2]), .E(E), .L(L), .Q(Q[2]) );
    muxdff	stage1	( .clk(clock), 	.w(Q[2]), 	.R(R[1]), .E(E), .L(L), .Q(Q[1]) );
    muxdff	stage0	( .clk(clock), 	.w(Q[1]), 	.R(R[0]), .E(E), .L(L), .Q(Q[0]) );
    
    assign			LEDR	=	Q;    

endmodule



module muxdff
(
    input clk,
    input w, R, E, L,
    
    output Q
);

    wire muxL, muxE;
    
    assign muxL = ( L ) ? R : muxE;
    assign muxE = ( E ) ? w : Q;
    
    always @ ( posedge clk ) begin
        Q <= muxL;
    end
endmodule
