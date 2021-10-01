module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    wire[4:0] inputs = { a, b, c, d, e};
    
    assign out = ~{{5{inputs[4]}}, {5{inputs[3]}}, {5{inputs[2]}}, {5{inputs[1]}}, {5{inputs[0]}}} ^ {5{inputs}};

endmodule
