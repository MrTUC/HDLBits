module top_module ( 
    input wire [2:0] vec, // This is a vector of bits holding three bits vec[2], vec[1] and vec[0].
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration

    assign outv = vec;
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];
    
endmodule
