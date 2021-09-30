/*
 * Take a careful look at the picture where the connectios are and do the assignments. Ports with the same direction and the same size can be collected together
 * and seperated with a comma.
 */
 
 module top_module ( 
    input a,b,c,
    output w,x,y,z );
	
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;
endmodule
