module top_module 
(
    input 			clk,
    input 			reset,
    
    output 			OneHertz,
    output	[2:0]	c_enable
); //
    
    wire	[3:0]	hundreds, tens, ones;
    
    assign	c_enable[0]	=	1'b1;
    assign	OneHertz	=	(12'b100110011001 == {hundreds, tens, ones}) ? 1'b1 : 1'b0;
    
    bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(ones) );
    bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(tens) );
    bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(hundreds) );
    
    assign c_enable[1] = (4'b1001 == ones) ? 1'b1 : 1'b0;
    assign c_enable[2] = (8'b10011001 == {tens, ones}) ? 1'b1 : 1'b0;

endmodule
