module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    
    localparam	ONE	=	4'b0001;

    count4 the_counter ( clk, c_enable, c_load, ONE, Q );
    
    assign 	c_load = reset | ((4'b1100 == Q) & enable);
    assign	c_enable	=	enable;
    assign	c_d			=	ONE;

endmodule
