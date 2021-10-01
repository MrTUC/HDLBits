module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire[7:0] q1d2, q2d3, q3mux;
	
    my_dff8 firststage 	( .clk(clk), .d(d), .q(q1d2) );
    my_dff8 secondstage ( .clk(clk), .d(q1d2), .q(q2d3) );
    my_dff8 thirdstage	( .clk(clk), .d(q2d3), .q(q3mux) );
    
    always @ (*) begin
        case (sel)
            2'b00	:	q = d;
            2'b01	:	q = q1d2;
            2'b10	:	q = q2d3;
            2'b11	:	q = q3mux;
            default	:	q = 2'b00;
        endcase
    end
    
    
endmodule
