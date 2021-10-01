/*
 *  In this file there are more gates generated with a for loop.
 *  The loop needs a name that is followed after the colon.
 */
module top_module ( 
    input [7:0] in,
    output [7:0] out
);

    genvar i;
    generate
        for ( i = 0; i <= 7; i = i + 1 ) begin : bitswapping
        	assign out[i] = in[7-i];
        end
    endgenerate
endmodule
