module top_module ( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    integer i;
    
    always @(*) begin
        for ( i = 0; i <= 255; i = i + 1 ) begin
            if ( sel == i )
                out = in[4*i+3 -:4];
        end // for 
    end // always @(*)
endmodule
