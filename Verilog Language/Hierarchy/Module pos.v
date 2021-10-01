/*
 *  You can also put the names of the inputs in the brackets. With this you have to be careful
 *  with the order. If you add ports or change the order in the future this might lead to some 
 *  errors.
 */
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);

    mod_a secondmodule ( out1, out2, a, b, c, d );
endmodule
