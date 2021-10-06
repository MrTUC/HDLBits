module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    wire[1:0] JK;
    assign JK = {j, k};
    reg out;
    assign Q = out;
    
    always @ ( posedge clk ) begin
        out <= out;
        case (JK )
            2'b01 : out <= 0;
            2'b10 : out <= 1;
            2'b11 : out <= ~out;
        endcase
    end // always

endmodule
