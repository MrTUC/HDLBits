module top_module ( input clk, input d, output q );

    wire q1d2, q2d3;
    
    my_dff firststage	( .clk(clk), .d(d), .q(q1d2) );
    my_dff secondstage	( .clk(clk), .d(q1d2), .q(q2d3) );
    my_dff thirdstage	( .clk(clk), .d(q2d3), .q(q) );
    
endmodule
