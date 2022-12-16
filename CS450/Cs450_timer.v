module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    
    reg [9:0] counter;
      
    always @ ( posedge clk ) begin
        if ( load )
            counter <= data;
        else if ( 10'd0 == counter )
            counter <= counter;
        else
            counter <= counter - 10'd1;
    end
    
    assign tc = ( 10'd0 == counter );

endmodule
