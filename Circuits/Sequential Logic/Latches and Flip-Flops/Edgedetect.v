module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg[7:0] edgedetect;
    
    always @ ( posedge clk ) begin
        edgedetect <= in;
    	pedge <= in & ~edgedetect;
    end // always
endmodule
