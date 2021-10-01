/*
 *  In this file the concatenation {} is used. The elements are seperated with a comma.
 *  Another use of the {} is the repetition. The number of repetitions is added before the {}.
 *  With {n{E}} the element E is repeated n times
 */
module top_module (
    input [7:0] in,
    output [31:0] out );//

    assign out = { {25{in[7]}}, in[6:0]};
    

endmodule
