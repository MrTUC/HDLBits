module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    wire muxL, muxE;
    
    assign muxL = ( L ) ? R : muxE;
    assign muxE = ( E ) ? w : Q;
    
    always @ ( posedge clk ) begin
        Q <= muxL;
    end
endmodule
