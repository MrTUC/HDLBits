module top_module ( 
    input a, 
    input b, 
    output out );
	
    assign out = ~(( ~a | ~b ) & (a | b));
    // xnor ( out, a, b );
    
endmodule
