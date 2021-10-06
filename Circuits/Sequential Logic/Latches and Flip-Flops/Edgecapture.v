module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg[31:0] previous, edges;
    
    always @ ( posedge clk ) begin
        if ( reset ) begin
            edges <= 0;
        	previous <= in;
        end else begin
            previous <= in;
            edges  <= edges | ~in & previous;
        end
    end // always

    assign out = edges;
endmodule
