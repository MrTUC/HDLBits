/*
 *  If you take a careful look at the Karnaugh Map, you'll find s.th. like a chessboard pattern.
 *  This pattern refers to an EXOR.
 */
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = a ^ b ^ c ^ d;

endmodule
