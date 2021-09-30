/*
 * OK, here's the first logic gate. You could also use a not-gate:
 * not firstgate ( out, in ); as an alternative to the assign statement.
 */
 
 module top_module ( input in, output out );

    assign out = ~in;
    
endmodule
 
