module top_module (
    input clk,
    input d,
    output q
);
    reg out1, out2;
    
    always @ (posedge clk)
        out1 <= d ^ out2;
    
    always @ (negedge clk)
        out2 <= d ^ out1;

    assign q = out1 ^ out2;
    
endmodule
