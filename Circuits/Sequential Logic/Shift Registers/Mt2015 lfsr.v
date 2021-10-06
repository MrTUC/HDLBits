module top_module 
(
	input	[2:0]	SW,      // R
	input 	[1:0]	KEY,     // L and clk
    
	output	[2:0]	LEDR
);  // Q

    wire	[2:0]	r_t;
    wire	[2:0]	q_t;
    wire			clock;
    wire			load_t;
    
    assign	clock	=	KEY[0];
    assign	load_t	=	KEY[1];
    assign	r_t		=	SW;
    assign	LEDR	=	q_t;
    
    sub_module stage0 ( .clk(clock), .L(load_t), .r_in(r_t[0]), .d_in(q_t[2]), .q_out(q_t[0]) );
    sub_module stage1 ( .clk(clock), .L(load_t), .r_in(r_t[1]), .d_in(q_t[0]), .q_out(q_t[1]) );
    sub_module stage2 ( .clk(clock), .L(load_t), .r_in(r_t[2]), .d_in(q_t[2]^q_t[1]), .q_out(q_t[2]) );

endmodule

module sub_module 
(
	input 			clk,
	input 			L,
	input 			r_in,
	input 			d_in,
    
	output reg		q_out
);
    
    wire 			muxout;
    
    assign muxout = ( L ) ? r_in : d_in;
    
    always @ (posedge clk) begin
       	q_out	<=	muxout;
    end // always

endmodule
