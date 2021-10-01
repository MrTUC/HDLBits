/*
 *  The .name() is the port or socket of the module and what's inside the brackets is plugged in.
 *  Just think of a jack and a socket: .socket(jack)
 */
module top_module ( input a, input b, output out );

    mod_a firstmodule ( .out(out), .in1(a), .in2(b) );
    
endmodule
