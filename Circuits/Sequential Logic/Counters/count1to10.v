module top_module (
    input clk,
    input reset,
    output [3:0] q);
    
    always @ ( posedge clk ) begin
        if ( reset | 4'd10 == q )
            q <= 4'd01;
        else
            q <= q + 1;
    end // always

endmodule
