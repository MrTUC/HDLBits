module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    wire muxout;
    
    assign muxout = ( L ) ? r_in : q_in;
    
    always @ (posedge clk) begin
       	Q <= muxout;
    end // always

endmodule
