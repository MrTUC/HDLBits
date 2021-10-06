module top_module (
    input clk,
    input in, 
    output out);
    
    wire gateout;
    assign gateout = in ^ out;
    
    always @ ( posedge clk ) begin
        out <= gateout;
    end // always
   

endmodule
