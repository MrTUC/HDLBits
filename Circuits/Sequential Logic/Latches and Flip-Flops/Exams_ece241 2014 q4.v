module top_module (
    input clk,
    input x,
    output z
); 
    
    wire[2:0] d, q;
    
    assign z = ~(|q);
    assign d[0] = q[0] ^ x;
    assign d[1] = ~q[1] & x;
    assign d[2] = ~q[2] | x;
    
    always @ ( posedge clk ) begin
        q <= d;
    end // always
    

endmodule
