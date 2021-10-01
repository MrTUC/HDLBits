`default_nettype none // I don't know, what  this line does.
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
    
    wire top, bottom; // Here is a declaration of the two internal wires.
    
    assign top = ( a & b );
    assign bottom = ( c & d );
    assign out = ( top | bottom );
    assign out_n = ~ ( top | bottom );

endmodule
