module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    
    reg[7:0] both;
    
    always @ (posedge clk) begin
        both <= in;
        anyedge <= (both & ~in) | (~both & in);
    end // always
    
endmodule
